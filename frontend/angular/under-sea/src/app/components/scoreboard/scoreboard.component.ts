import { Component, OnInit } from '@angular/core';
import { UserListItem } from 'src/app/models/userlist-item.model';

@Component({
  selector: 'scoreboard',
  templateUrl: './scoreboard.component.html',
  styleUrls: ['./scoreboard.component.scss']
})
export class ScoreboardComponent implements OnInit {

  scoreboard: Array<UserListItem> = [
    {
      placement: 1,
      name: "Pista",
      score: 1234,
    },
    {
      placement: 1,
      name: "Pista",
      score: 1234,
    },
    {
      placement: 1,
      name: "Pista",
      score: 1234,
    },
    {
      placement: 1,
      name: "Pista",
      score: 1234,
    },
  ];
  constructor() { }

  ngOnInit(): void {
  }

}
