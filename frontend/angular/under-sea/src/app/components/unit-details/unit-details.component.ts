import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { UnitDetails } from 'src/app/models/unit-details.model';

@Component({
  selector: 'unit-details',
  templateUrl: './unit-details.component.html',
  styleUrls: ['./unit-details.component.scss'],
})
export class UnitDetailsComponent implements OnInit {
  @Input() unit: UnitDetails;
  @Input() remainingMoney: number;
  @Output() countModified: EventEmitter<{
    id: string;
    count: number;
    price: number;
  }> = new EventEmitter();
  selected: number = 0;

  constructor() {}

  ngOnInit(): void {}

  increment(): void {
    this.selected++;
    this.countModified.emit({
      id: this.unit.id,
      count: this.selected,
      price: this.unit.price,
    });
  }

  decrement(): void {
    this.selected--;
    this.countModified.emit({
      id: this.unit.id,
      count: this.selected,
      price: this.unit.price,
    });
  }

  canIncrement(): boolean {
    return this.remainingMoney >= (this.selected + 1) * this.unit.price;
  }

  canDecrement(): boolean {
    return this.selected > 0;
  }
}
