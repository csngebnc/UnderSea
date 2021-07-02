import { Component, OnInit, OnDestroy } from '@angular/core';
import { BuildingDetails } from 'src/app/models/building-details.model';
import { BehaviorSubject, Observable, Subject } from 'rxjs';
import { BuildingService } from 'src/app/services/building/building.service';
import { Store, Select } from '@ngxs/store';
import { ResourcesState } from 'src/app/states/resources/resources.state';
import { GetResources } from 'src/app/states/resources/resources.actions';
import { takeUntil } from 'rxjs/operators';

@Component({
  selector: 'buildings',
  templateUrl: './buildings.component.html',
  styleUrls: ['./buildings.component.scss'],
})
export class BuildingsComponent implements OnInit, OnDestroy {
  selectedBuilding: number | null = null;
  isUnderConstruction: boolean = false;
  buildings: Array<BuildingDetails> = [];

  @Select(ResourcesState.pearls)
  private pearlCount$: Observable<number>;

  private destroy$ = new Subject<void>();

  money: number = 0;
  isLoading$ = new BehaviorSubject(false);

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
    this.isLoading$.next(true);

    this.buildingService.getBuildings().subscribe(
      (r) => {
        this.buildings = r;

        this.checkUnderConstruction();
        this.isLoading$.next(false);
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
