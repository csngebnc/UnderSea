import { Component, OnInit, Input } from '@angular/core';
import { Resources } from 'src/app/models/resources.model';

@Component({
  selector: 'sidebar',
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.scss'],
})
export class SidebarComponent implements OnInit {
  @Input() userName: string;

  constructor() {}

  ngOnInit(): void {}
}
