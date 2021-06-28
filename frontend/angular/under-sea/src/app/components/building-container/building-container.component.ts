import { Component, OnInit, Input } from '@angular/core';
import { Resource } from 'src/app/models/resource.model';

@Component({
  selector: 'building-container',
  templateUrl: './building-container.component.html',
  styleUrls: ['./building-container.component.scss'],
})
export class BuildingContainerComponent implements OnInit {
  @Input() buildings: Array<Resource>;

  constructor() {}

  ngOnInit(): void {}

  playerHasBuilding(name: string): boolean {
    let result = this.buildings.find((c) => c.name === name);

    if (!result || result.count === 0) return false;
    else return true;
  }

  nextRound(): void {
    console.log('kövi kör');
  }
}
