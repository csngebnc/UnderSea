import { Component, OnInit } from '@angular/core';
import { AttackerUnit } from 'src/app/models/attacker-unit.model';
import { UserListItem } from '../../models/userlist-item.model';
import { AttackerUnitDto } from 'src/app/models/dto/attacker-unit-dto.model';

@Component({
  selector: 'attack',
  templateUrl: './attack.component.html',
  styleUrls: ['./attack.component.scss'],
})
export class AttackComponent implements OnInit {
  units: Array<AttackerUnit> = [
    {
      id: 1,
      name: 'Lézercápa',
      count: 30,
    },
    {
      id: 2,
      name: 'Rohamfóka',
      count: 12,
    },
  ];

  players: Array<UserListItem> = [
    {
      id: '1',
      countryId: 1,
      name: 'Gipsz Jakab',
    },
    {
      id: '2',
      countryId: 2,
      name: 'Gipsz Jakab',
    },
    {
      id: '3',
      countryId: 3,
      name: 'Gipsz Jakab',
    },
    {
      id: '4',
      countryId: 4,
      name: 'Gipsz Jakab',
    },
    {
      id: '5',
      countryId: 5,
      name: 'Gipsz Jakab',
    },
    {
      id: '6',
      countryId: 6,
      name: 'Gipsz Jakab',
    },
    {
      id: '7',
      countryId: 7,
      name: 'Gipsz Jakab',
    },
  ];

  targetId: number;
  attackerUnits: Array<AttackerUnitDto> = [];

  pageNumber: number = 1;
  pageSize: number = 2;
  allResultsCount: number = 5;
  constructor() {}

  ngOnInit(): void {
    this.units.forEach((unit) => {
      this.attackerUnits.push({ id: unit.id, count: 0 });
    });
  }

  onSelectTarget(id: number): void {
    this.targetId = id;
  }

  onSetUnit(unit: AttackerUnitDto): void {
    let index = this.attackerUnits.findIndex((u) => u.id === unit.id);
    this.attackerUnits[index].count = unit.count;
  }

  isButtonDisabled(): boolean {
    let sum: number = 0;
    this.attackerUnits.forEach((unit) => {
      sum += unit.count;
    });

    return !(this.targetId && sum);
  }

  onSwitchPage(pageNumber: number): void {
    this.pageNumber = pageNumber;
  }
}
