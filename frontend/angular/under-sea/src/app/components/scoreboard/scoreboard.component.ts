import { Component, OnInit } from '@angular/core';
import { UserListItem } from 'src/app/models/userlist-item.model';

@Component({
  selector: 'scoreboard',
  templateUrl: './scoreboard.component.html',
  styleUrls: ['./scoreboard.component.scss'],
})
export class ScoreboardComponent implements OnInit {
  scoreboard: Array<UserListItem> = [
    {
      id: '1',
      placement: 1,
      name: 'Pista',
      score: 1234,
    },
    {
      id: '2',
      placement: 1,
      name: 'Pista',
      score: 1234,
    },
    {
      id: '3',
      placement: 1,
      name: 'Pista',
      score: 1234,
    },
    {
      id: '4',
      placement: 1,
      name: 'Pista',
      score: 1234,
    },
  ];
  constructor() {}

  ngOnInit(): void {}
}
