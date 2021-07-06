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
  @Input() resources: Resources;

  constructor() {}

  ngOnInit(): void {}
}
