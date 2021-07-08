import { Material } from './../../models/material.model';
import { Component, OnInit, OnDestroy } from '@angular/core';
import { BuildingDetails } from 'src/app/models/building-details.model';
import { Observable, Subject } from 'rxjs';
import { BuildingService } from 'src/app/services/building/building.service';
import { Store, Select } from '@ngxs/store';
import { ResourcesState } from 'src/app/states/resources/resources.state';
import { GetResources } from 'src/app/states/resources/resources.actions';
import { takeUntil } from 'rxjs/operators';
import { LoadingState } from 'src/app/states/loading/loading.state';
import { findNode } from '@angular/compiler';

@Component({
  selector: 'buildings',
  templateUrl: './buildings.component.html',
  styleUrls: ['./buildings.component.scss'],
})
export class BuildingsComponent implements OnInit, OnDestroy {
  selectedBuilding: number | null = null;
  isUnderConstruction: boolean = false;
  buildings: Array<BuildingDetails> = [];

  @Select(LoadingState.isLoading)
  loading$: Observable<boolean>;

  @Select(ResourcesState.materials)
  private materialCount$: Observable<Array<Material>>;

  private destroy$ = new Subject<void>();

  materials: Array<Material> = [];
  priceTooHigh: boolean = false;

  constructor(private buildingService: BuildingService, private store: Store) {
    this.materialCount$
      .pipe(takeUntil(this.destroy$))
      .subscribe((m) => (this.materials = m));
  }

  ngOnInit(): void {
    this.initBuildings();
  }

  ngOnDestroy(): void {
    this.destroy$.next();
  }

  private initBuildings(): void {
    this.buildingService.getBuildings().subscribe(
      (r) => {
        this.buildings = r;

        this.checkUnderConstruction();
      },
      (e) => console.error(e)
    );
  }

  private checkUnderConstruction(): void {
    this.buildings.forEach((b) => {
      if (b.underConstruction) this.isUnderConstruction = true;
    });
  }

  setBuilding(building: BuildingDetails): void {
    this.selectedBuilding = building.id;
    this.priceTooHigh = this.materials.some((m: Material) => {
      const found = building.price.find((p: Material) => p.id === m.id);
      if (!found) return false;
      else return m.count < found.count;
    });
  }

  onBuy(): void {
    this.buildingService.buyBuilding(this.selectedBuilding).subscribe(
      (r) => {
        this.isUnderConstruction = true;
        this.store.dispatch(GetResources);
      },
      (e) => console.error(e)
    );
  }
}
