import { Component, OnInit } from '@angular/core';
import { BuildingDetails } from 'src/app/models/building-details.model';
import { BehaviorSubject, forkJoin, Observable } from 'rxjs';
import { BuildingService } from 'src/app/services/building/building.service';
import { ApiService } from 'src/app/services/api/api.service';
import { Store, Select } from '@ngxs/store';
import { ResourcesState } from 'src/app/states/resources/resources.state';
import { GetResources } from 'src/app/states/resources/resources.actions';

@Component({
  selector: 'buildings',
  templateUrl: './buildings.component.html',
  styleUrls: ['./buildings.component.scss'],
})
export class BuildingsComponent implements OnInit {
  selectedBuilding: number | null = null;
  isUnderConstruction: boolean = false;
  buildings: Array<BuildingDetails> = [];

  @Select(ResourcesState.pearls)
  private pearlCount: Observable<number>;

  money: number = 0;
  isLoading = new BehaviorSubject(false);

  constructor(
    private buildingService: BuildingService,
    private apiService: ApiService,
    private store: Store
  ) {
    this.pearlCount.subscribe((m) => (this.money = m));
  }

  ngOnInit(): void {
    this.initBuildings();
  }

  private initBuildings(): void {
    this.isLoading.next(true);

    this.buildingService.getBuildings().subscribe(
      (r) => {
        this.buildings = r;

        this.checkUnderConstruction();
        this.isLoading.next(false);
      },
      (e) => console.log(e)
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

        console.log(r);
      },
      (e) => console.log(e)
    );
  }
}
