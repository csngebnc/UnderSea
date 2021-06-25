import { Component, OnInit, Input } from '@angular/core';
import { AttackerUnit } from 'src/app/models/attacker-unit.model';

@Component({
  selector: 'unit-slider',
  templateUrl: './unit-slider.component.html',
  styleUrls: ['./unit-slider.component.scss'],
})
export class UnitSliderComponent implements OnInit {
  @Input() unit: AttackerUnit;
  selectedCount: number = 0;

  constructor() {}

  ngOnInit(): void {}
}
