import { Component, OnInit } from '@angular/core';
import { UserData } from 'src/app/models/userdata.model';
import { Resources } from 'src/app/models/resources.model';

@Component({
  selector: 'infobar',
  templateUrl: './infobar.component.html',
  styleUrls: ['./infobar.component.scss'],
})
export class InfobarComponent implements OnInit {
  constructor() {}

  ngOnInit(): void {}

  userData: UserData = {
    name: 'Pepsi Béla',
    round: 12,
    placement: 11,
    country: 'Neverland',
  };

  resources: Resources = {
    units: [],
    buildings: [],
    buildingsUnderConstruction: [],
    shells: 123,
    shellsPerRound: 12,
    corals: 126,
    coralsPerRound: 32
  }
}
