import { Component, OnInit } from '@angular/core';
import { UserData } from 'src/app/models/userdata.model';
import { Resources } from 'src/app/models/resources.model';

@Component({
  selector: 'main',
  templateUrl: './main.component.html',
  styleUrls: ['./main.component.scss']
})
export class MainComponent implements OnInit {

  constructor() { }

  ngOnInit(): void {
  }

  userData: UserData = {
    name: 'Pepsi Béla',
    round: 12,
    placement: 11,
    country: 'Neverland',
  };

  resources: Resources = {
    units: [
      { id: 1, name: 'shark', count: 10 },
      { id: 1, name: 'shark', count: 10 },
      { id: 1, name: 'shark', count: 10 },
    ],
    buildings: [
      { id: 1, name: 'shark', count: 11 },
      { id: 2, name: 'shark', count: 12 },
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
