import { Component, OnInit, Input } from '@angular/core';
import { UserData } from 'src/app/models/userdata.model';
import { Resources } from 'src/app/models/resources.model';

@Component({
  selector: 'sidebar',
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.scss']
})
export class SidebarComponent implements OnInit {

  @Input() userData: UserData;
  @Input()  resources: Resources;


  constructor() { }

  ngOnInit(): void {
  }

}
