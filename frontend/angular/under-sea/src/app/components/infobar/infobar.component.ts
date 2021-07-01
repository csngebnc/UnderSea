import { Component, OnInit, Input } from '@angular/core';
import { Resources } from 'src/app/models/resources.model';
import * as config from 'src/assets/config.json';

@Component({
  selector: 'infobar',
  templateUrl: './infobar.component.html',
  styleUrls: ['./infobar.component.scss'],
})
export class InfobarComponent implements OnInit {
  @Input() round: number;
  @Input() placement: number;
  @Input() resources: Resources;

  coralImg = config.imageUrl + config.images.coral;
  pearlImg = config.imageUrl + config.images.pearl;

  constructor() {}

  ngOnInit(): void {}
}
