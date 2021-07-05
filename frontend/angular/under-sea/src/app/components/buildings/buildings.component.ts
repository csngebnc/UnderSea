import { Component, OnInit, OnDestroy } from '@angular/core';
import { BuildingDetails } from 'src/app/models/building-details.model';
import { Observable, Subject } from 'rxjs';
import { BuildingService } from 'src/app/services/building/building.service';
import { Store, Select } from '@ngxs/store';
import { ResourcesState } from 'src/app/states/resources/resources.state';
import { GetResources } from 'src/app/states/resources/resources.actions';
import { takeUntil } from 'rxjs/operators';
import { LoadingState } from 'src/app/states/loading/loading.state';

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

  @Select(ResourcesState.pearls)
  private pearlCount$: Observable<number>;

  private destroy$ = new Subject<void>();

  money: number = 0;

  constructor(private buildingService: BuildingService, private store: Store) {
    this.pearlCount$
      .pipe(takeUntil(this.destroy$))
      .subscribe((m) => (this.money = m));
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

  setBuilding(id: number): void {
    this.selectedBuilding = id;
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
