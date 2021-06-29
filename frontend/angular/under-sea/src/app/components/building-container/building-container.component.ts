import { Component, OnInit, Input } from '@angular/core';
import { Building } from 'src/app/models/building.model';

@Component({
  selector: 'building-container',
  templateUrl: './building-container.component.html',
  styleUrls: ['./building-container.component.scss'],
})
export class BuildingContainerComponent implements OnInit {
  @Input() buildings: Array<Building>;

  constructor() {}

  ngOnInit(): void {}

  playerHasBuilding(name: string): boolean {
    let result = this.buildings.find((c) => c.name === name);

    if (!result || result.buildingsCount === 0) return false;
    else return true;
  }

  nextRound(): void {
    console.log('kövi kör');
  }
}
