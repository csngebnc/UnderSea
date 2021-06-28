import { Component, OnInit } from '@angular/core';
import { Battle } from 'src/app/models/battle.model';

@Component({
  selector: 'battle',
  templateUrl: './battle.component.html',
  styleUrls: ['./battle.component.scss'],
})
export class BattleComponent implements OnInit {
  battles: Array<Battle> = [
    {
      target: 'kukutyim',
      units: [
        {
          count: 32,
          name: 'Kiskutya',
        },
        {
          count: 22,
          name: 'Csicskalángos',
        },
        {
          count: 32,
          name: 'Volkswagen',
        },
      ],
    },
    {
      target: 'Románia',
      result: 'győzelem',
      units: [
        {
          count: 32,
          name: 'asdasd',
        },
        {
          count: 22,
          name: 'V4',
        },
        {
          count: 32,
          name: 'lorem ipsum',
        },
      ],
    },
  ];

  pageNumber: number = 1;
  pageSize: number = 2;
  allResultsCount: number = 5;
  constructor() {}

  ngOnInit(): void {}

  onSwitchPage(pageNumber: number): void {
    this.pageNumber = pageNumber;
  }
}
