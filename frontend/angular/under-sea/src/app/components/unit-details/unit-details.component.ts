import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { UnitDetails } from 'src/app/models/unit-details.model';
import { CartUnit } from 'src/app/models/cart-unit.model';
import { Store } from '@ngxs/store';
import {
  IncrementCapacity,
  DecrementCapacity,
} from 'src/app/states/resources/resources.actions';

@Component({
  selector: 'unit-details',
  templateUrl: './unit-details.component.html',
  styleUrls: ['./unit-details.component.scss'],
})
export class UnitDetailsComponent implements OnInit {
  @Input() unit: UnitDetails;
  @Input() remainingMoney: number;
  @Input() remainingCapacity: number;
  @Output() countModified: EventEmitter<CartUnit> = new EventEmitter();
  selected: number = 0;

  constructor(private store: Store) {}

  ngOnInit(): void {}

  increment(): void {
    this.store.dispatch(DecrementCapacity);
    this.selected++;
    this.countModified.emit({
      unitId: this.unit.id,
      count: this.selected,
      price: this.unit.price,
    });
  }

  decrement(): void {
    this.store.dispatch(IncrementCapacity);
    this.selected--;
    this.countModified.emit({
      unitId: this.unit.id,
      count: this.selected,
      price: this.unit.price,
    });
  }

  canIncrement(): boolean {
    return this.remainingMoney >= this.unit.price && this.remainingCapacity > 0;
  }

  canDecrement(): boolean {
    return this.selected > 0;
  }
}
