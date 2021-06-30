import { Component, OnInit } from '@angular/core';
import { BuildingDetails } from 'src/app/models/building-details.model';
import { BehaviorSubject, forkJoin } from 'rxjs';
import { BuildingService } from 'src/app/services/building/building.service';
import { UserService } from 'src/app/services/user/user.service';

@Component({
  selector: 'buildings',
  templateUrl: './buildings.component.html',
  styleUrls: ['./buildings.component.scss'],
})
export class BuildingsComponent implements OnInit {
  selectedBuilding: number | null = null;
  isUnderConstruction: boolean = false;
  buildings: Array<BuildingDetails> = [];
  money: number = 0;
  isLoading = new BehaviorSubject(false);

  constructor(
    private buildingService: BuildingService,
    private userService: UserService
  ) {}

  ngOnInit(): void {
    this.initBuildings();
  }

  private initBuildings(): void {
    this.isLoading.next(true);

    let buildings = this.buildingService.getBuildings();
    let pearls = this.userService.getPearlCount();

    forkJoin([buildings, pearls]).subscribe(
      (responses) => {
        this.buildings = responses[0];
        this.money = responses[1];

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
        this.initBuildings();

        console.log(r);
      },
      (e) => console.log(e)
    );
  }
}
