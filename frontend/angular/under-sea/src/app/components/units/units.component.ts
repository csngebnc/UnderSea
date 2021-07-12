import { ToastrService } from 'ngx-toastr';
import { Component, OnInit, OnDestroy } from '@angular/core';
import { UnitDetails } from 'src/app/models/unit-details.model';
import { CartUnit } from 'src/app/models/cart-unit.model';
import { BattleService } from 'src/app/services/battle/battle.service';
import { BehaviorSubject, Observable, Subject } from 'rxjs';
import { Store, Select } from '@ngxs/store';
import { ResourcesState } from 'src/app/states/resources/resources.state';
import { GetResources } from 'src/app/states/resources/resources.actions';
import { takeUntil } from 'rxjs/operators';
import { LoadingState } from 'src/app/states/loading/loading.state';
import { AttackUnit } from 'src/app/models/attack-unit.model';

@Component({
  selector: 'units',
  templateUrl: './units.component.html',
  styleUrls: ['./units.component.scss'],
})
export class UnitsComponent implements OnInit, OnDestroy {
  units: Array<UnitDetails> = [];
  cart: Array<AttackUnit> = [];
  emptyCart = true;
  remainingMoney: number;
  justBoughtUnits$ = new BehaviorSubject(false);

  @Select(LoadingState.isLoading)
  loading$: Observable<boolean>;

  @Select(ResourcesState.remainingCapacity)
  remainingCapacity$: Observable<number>;

  @Select(ResourcesState.pearls)
  money$: Observable<number>;

  destroy$ = new Subject<void>();

  constructor(
    private battleService: BattleService,
    private store: Store,
    private toastr: ToastrService
  ) {}

  ngOnInit(): void {
    this.initUnits();
    this.money$.pipe(takeUntil(this.destroy$)).subscribe((m) => {
      this.remainingMoney = m;
    });
  }

  ngOnDestroy(): void {
    this.destroy$.next();
  }

  private initUnits(): void {
    this.battleService.getUnits().subscribe(
      (response) => {
        this.units = response;
      },
      (e) => {
        const error = JSON.parse(e['response']);
        const errorText = Object.values(error['errors'])[0][0];
        this.toastr.error(errorText);
      }
    );
  }

  addToCart(unit: CartUnit): void {
    const index = this.cart.findIndex((u) => u.unitId === unit.unitId);
    if (index !== -1) {
      this.remainingMoney += this.cart[index].count * unit.price;
      this.cart[index].count = unit.count;
      this.remainingMoney -= unit.count * unit.price;
    } else {
      this.remainingMoney -= unit.count * unit.price;
      this.cart.push({ unitId: unit.unitId, count: unit.count });
    }

    this.emptyCart = this.isCartEmpty();
  }

  private isCartEmpty(): boolean {
    let sum = 0;
    this.cart.forEach((u) => (sum += u.count));

    return !sum;
  }

  onBuy(): void {
    this.justBoughtUnits$.next(true);
    this.battleService.buyUnits({ units: this.cart }).subscribe(
      (r) => {
        this.store.dispatch(GetResources);
      },
      (e) => {
        const error = JSON.parse(e['response']);
        const errorText = Object.values(error['errors'])[0][0];
        this.toastr.error(errorText);
      }
    );
  }
}
