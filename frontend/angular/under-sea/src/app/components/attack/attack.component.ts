import { Component, OnInit } from '@angular/core';
import { AttackerUnit } from 'src/app/models/attacker-unit.model';
import { UserListItem } from '../../models/userlist-item.model';

@Component({
  selector: 'attack',
  templateUrl: './attack.component.html',
  styleUrls: ['./attack.component.scss'],
})
export class AttackComponent implements OnInit {
  units: Array<AttackerUnit> = [
    {
      id: 'shark',
      name: 'Lézercápa',
      count: 30,
    },
    {
      id: 'seal',
      name: 'Rohamfóka',
      count: 12,
    },
  ];

  players: Array<UserListItem> = [
    {
      name: 'Gipsz Jakab',
    },
    {
      name: 'Gipsz Jakab',
    },
    {
      name: 'Gipsz Jakab',
    },
    {
      name: 'Gipsz Jakab',
    },
    {
      name: 'Gipsz Jakab',
    },
    {
      name: 'Gipsz Jakab',
    },
    {
      name: 'Gipsz Jakab',
    },
  ];

  constructor() {}

  ngOnInit(): void {}
}
