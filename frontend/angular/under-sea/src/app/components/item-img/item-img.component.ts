import { Component, OnInit, Input } from '@angular/core';
import { Effect } from 'src/app/models/effect.model';

@Component({
  selector: 'item-img',
  templateUrl: './item-img.component.html',
  styleUrls: ['./item-img.component.scss'],
})
export class ItemImgComponent implements OnInit {
  @Input() img: string;
  @Input() name: string;
  @Input() effects: Array<Effect>;

  constructor() { }

  ngOnInit(): void { }
}
