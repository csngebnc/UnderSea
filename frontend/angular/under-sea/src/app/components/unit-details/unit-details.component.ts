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
import { Store, Select } from '@ngxs/store';
import {
  IncrementCapacity,
  DecrementCapacity,
} from 'src/app/states/resources/resources.actions';
import { BehaviorSubject, Subject, Observable } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { LoadingState } from 'src/app/states/loading/loading.state';

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
  selected: number = 0;
  private destroy$ = new Subject<void>();

  constructor(private store: Store) {}

  ngOnInit(): void {
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
}
