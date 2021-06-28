import { Component, OnInit } from '@angular/core';
import { Upgrade } from 'src/app/models/upgrade.model';

@Component({
  selector: 'upgrades',
  templateUrl: './upgrades.component.html',
  styleUrls: ['./upgrades.component.scss'],
})
export class UpgradesComponent implements OnInit {
  selectedUpgrade: string = '';
  isResearching: boolean = false;

  upgrades: Array<Upgrade> = [
    {
      id: 1,
      name: 'Korall fal',
      exists: true,
      underConstruction: false,
      effects: [{ id: 1, name: 'asd' }],
    },
    {
      id: 2,
      name: 'Korall fal',
      exists: true,
      underConstruction: false,
      effects: [{ id: 1, name: 'asd' }],
    },
    {
      id: 3,
      name: 'Korall fal',
      exists: true,
      underConstruction: false,
      effects: [{ id: 1, name: 'asd' }],
    },
    {
      id: 4,
      name: 'Korall fal',
      exists: true,
      underConstruction: false,
      effects: [{ id: 1, name: 'asd' }],
    },
    {
      id: 5,
      name: 'Korall fal',
      exists: true,
      underConstruction: false,
      effects: [{ id: 1, name: 'asd' }],
    },
    {
      id: 6,
      name: 'Korall fal',
      exists: true,
      underConstruction: false,
      effects: [{ id: 1, name: 'asd' }],
    },
  ];

  constructor() {}

  ngOnInit(): void {}

  setUpgrade(id: string): void {
    this.selectedUpgrade = id;
  }

  onBuy(): void {
    console.log(this.selectedUpgrade);
    this.isResearching = true;
  }
}
