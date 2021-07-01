import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { UnitDetails } from 'src/app/models/unit-details.model';
import { CartUnit } from 'src/app/models/cart-unit.model';

@Component({
  selector: 'unit-details',
  templateUrl: './unit-details.component.html',
  styleUrls: ['./unit-details.component.scss'],
})
export class UnitDetailsComponent implements OnInit {
  @Input() unit: UnitDetails;
  @Input() remainingMoney: number;
  @Output() countModified: EventEmitter<CartUnit> = new EventEmitter();
  selected: number = 0;

  constructor() {}

  ngOnInit(): void {}

  increment(): void {
    this.selected++;
    this.countModified.emit({
      unitId: this.unit.id,
      count: this.selected,
      price: this.unit.price,
    });
  }

  decrement(): void {
    this.selected--;
    this.countModified.emit({
      unitId: this.unit.id,
      count: this.selected,
      price: this.unit.price,
    });
  }

  canIncrement(): boolean {
    return this.remainingMoney >= this.unit.price;
  }

  canDecrement(): boolean {
    return this.selected > 0;
  }
}
