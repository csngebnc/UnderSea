import {
  Component,
  OnInit,
  Input,
  Output,
  EventEmitter,
  OnDestroy,
} from '@angular/core';
import { UnitDetails } from 'src/app/models/unit-details.model';
import { CartUnit } from 'src/app/models/cart-unit.model';
import { Store } from '@ngxs/store';
import {
  IncrementCapacity,
  DecrementCapacity,
} from 'src/app/states/resources/resources.actions';
import { BehaviorSubject, Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';

@Component({
  selector: 'unit-details',
  templateUrl: './unit-details.component.html',
  styleUrls: ['./unit-details.component.scss'],
})
export class UnitDetailsComponent implements OnInit, OnDestroy {
  @Input() unit: UnitDetails;
  @Input() remainingMoney: number;
  @Input() remainingCapacity: number;
  @Input() justBoughtUnits$: BehaviorSubject<boolean>;
  @Output() countModified: EventEmitter<CartUnit> = new EventEmitter();
  unitPrice: number = 0;
  selected: number = 0;
  private destroy$ = new Subject<void>();

  constructor(private store: Store) {}

  ngOnInit(): void {
    this.unitPrice = this.unit.price.find((m) => m.id === 1).count;
    this.justBoughtUnits$.pipe(takeUntil(this.destroy$)).subscribe(() => {
      this.selected = 0;
    });
  }

  ngOnDestroy(): void {
    this.destroy$.next();
  }

  increment(): void {
    this.store.dispatch(DecrementCapacity);
    this.selected++;
    this.countModified.emit({
      unitId: this.unit.id,
      count: this.selected,
      price: this.unitPrice,
    });
  }

  decrement(): void {
    this.store.dispatch(IncrementCapacity);
    this.selected--;
    this.countModified.emit({
      unitId: this.unit.id,
      count: this.selected,
      price: this.unitPrice,
    });
  }
}
