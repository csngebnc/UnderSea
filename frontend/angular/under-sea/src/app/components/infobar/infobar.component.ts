import { Component, OnInit, Input } from '@angular/core';
import { UserData } from 'src/app/models/userdata.model';
import { Resources } from 'src/app/models/resources.model';

@Component({
  selector: 'infobar',
  templateUrl: './infobar.component.html',
  styleUrls: ['./infobar.component.scss'],
})
export class InfobarComponent implements OnInit {

  @Input() userData: UserData;
  @Input()  resources: Resources;


  constructor() {}

  ngOnInit(): void {}

  countUnderConstrction(id: number): number{
    let result = this.resources.buildingsUnderConstruction.find(b => b.id === id);
    if(!result) return 0;
    else return result.count;
  }
}
