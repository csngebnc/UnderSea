import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { AttackerUnit } from 'src/app/models/attacker-unit.model';
import { AttackerUnitDto } from 'src/app/models/dto/attacker-unit-dto.model';

@Component({
  selector: 'unit-slider',
  templateUrl: './unit-slider.component.html',
  styleUrls: ['./unit-slider.component.scss'],
})
export class UnitSliderComponent implements OnInit {
  @Input() unit: AttackerUnit;
  @Output() setUnit = new EventEmitter<AttackerUnitDto>();
  selectedCount: number = 0;

  constructor() {}

  ngOnInit(): void {}

  setUnitCount(id: number, count: string): void {
    this.setUnit.emit({ id: id, count: parseInt(count) });
  }
}
