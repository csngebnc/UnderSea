import { Component, OnInit, Input } from '@angular/core';
import { Resources } from 'src/app/models/resources.model';

@Component({
  selector: 'infobar',
  templateUrl: './infobar.component.html',
  styleUrls: ['./infobar.component.scss'],
})
export class InfobarComponent implements OnInit {

  @Input() round: number;
  @Input() placement: number;
  @Input()  resources: Resources;


  constructor() {}

  ngOnInit(): void {}

  countUnderConstrction(id: number): number{
    let result = this.resources.buildingsUnderConstruction.find(b => b.id === id);
    if(!result) return 0;
    else return result.count;
  }
}
