import { Component, OnInit } from '@angular/core';
import { UserData } from 'src/app/models/userdata.model';
import { Resources } from 'src/app/models/resources.model';

@Component({
  selector: 'main',
  templateUrl: './main.component.html',
  styleUrls: ['./main.component.scss'],
})
export class MainComponent implements OnInit {
  constructor() {}

  ngOnInit(): void {}

  userData: UserData = {
    name: 'Pepsi Béla',
    round: 12,
    placement: 11,
  };

  resources: Resources = {
    units: [
      { id: 1, name: 'shark', count: 10 },
      { id: 1, name: 'shark', count: 10 },
      { id: 1, name: 'shark', count: 10 },
    ],
    buildings: [
      { id: 1, name: 'sonar', count: 1 },
      { id: 2, name: 'flow-control', count: 12 },
      { id: 2, name: 'castle', count: 12 },
    ],
    buildingsUnderConstruction: [
      { id: 1, name: 'shark', count: 1 },
      { id: 1, name: 'shark', count: 0 },
    ],
    shells: 123,
    shellsPerRound: 12,
    corals: 126,
    coralsPerRound: 32,
  };
}
