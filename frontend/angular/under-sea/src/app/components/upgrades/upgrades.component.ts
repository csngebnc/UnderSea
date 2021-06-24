import { Component, OnInit } from '@angular/core';
import { Upgrade } from 'src/app/models/upgrade.model';

@Component({
  selector: 'upgrades',
  templateUrl: './upgrades.component.html',
  styleUrls: ['./upgrades.component.scss'],
})
export class UpgradesComponent implements OnInit {
  upgrades: Array<Upgrade> = [
    {
      id: 'coral_wall',
      name: 'Korall fal',
      exists: true,
      underConstruction: false,
      effects: [{ id: 1, name: 'asd' }],
    },
    {
      id: 'coral_wall',
      name: 'Korall fal',
      exists: true,
      underConstruction: false,
      effects: [{ id: 1, name: 'asd' }],
    },
    {
      id: 'coral_wall',
      name: 'Korall fal',
      exists: true,
      underConstruction: false,
      effects: [{ id: 1, name: 'asd' }],
    },
    {
      id: 'coral_wall',
      name: 'Korall fal',
      exists: true,
      underConstruction: false,
      effects: [{ id: 1, name: 'asd' }],
    },
    {
      id: 'coral_wall',
      name: 'Korall fal',
      exists: true,
      underConstruction: false,
      effects: [{ id: 1, name: 'asd' }],
    },
    {
      id: 'coral_wall',
      name: 'Korall fal',
      exists: true,
      underConstruction: false,
      effects: [{ id: 1, name: 'asd' }],
    },
  ];

  constructor() {}

  ngOnInit(): void {}
}
