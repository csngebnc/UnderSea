import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { AttackerUnit } from 'src/app/models/attacker-unit.model';
import { AttackUnitDto } from 'src/app/services/generated-code/generated-api-code';

@Component({
  selector: 'unit-slider',
  templateUrl: './unit-slider.component.html',
  styleUrls: ['./unit-slider.component.scss'],
})
export class UnitSliderComponent implements OnInit {
  @Input() unit: AttackerUnit;
  @Output() setUnit = new EventEmitter<AttackUnitDto>();
  selectedCount = 0;

  constructor() { }

  ngOnInit(): void { }

  setUnitCount(id: number, count: string): void {
    this.setUnit.emit({ unitId: id, count: parseInt(count) });
  }
}
