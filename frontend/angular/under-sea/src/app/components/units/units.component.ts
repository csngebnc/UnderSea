import { Component, OnInit, OnDestroy } from '@angular/core';
import { UnitDetails } from 'src/app/models/unit-details.model';
import { CartUnit } from 'src/app/models/cart-unit.model';
import { BattleService } from 'src/app/services/battle/battle.service';
import { BehaviorSubject, Observable, Subject } from 'rxjs';
import { BuyUnitDto } from 'src/app/services/generated-code/generated-api-code';
import { Store, Select } from '@ngxs/store';
import { ResourcesState } from 'src/app/states/resources/resources.state';
import { GetResources } from 'src/app/states/resources/resources.actions';
import { takeUntil } from 'rxjs/operators';
import { LoadingState } from 'src/app/states/loading/loading.state';

@Component({
  selector: 'units',
  templateUrl: './units.component.html',
  styleUrls: ['./units.component.scss'],
})
export class UnitsComponent implements OnInit, OnDestroy {
  units: Array<UnitDetails> = [];
  cart: BuyUnitDto = { units: [] };
  remainingMoney: number;
  justBoughtUnits$ = new BehaviorSubject(false);

  @Select(LoadingState.isLoading)
  loading$: Observable<boolean>;

  @Select(ResourcesState.remainingCapacity)
  remainingCapacity$: Observable<number>;

  @Select(ResourcesState.pearls)
  money$: Observable<number>;

  destroy$ = new Subject<void>();

  constructor(private battleService: BattleService, private store: Store) {}

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
      (e) => console.error(e)
    );
  }

  addToCart(unit: CartUnit): void {
    let index = this.cart.units.findIndex((u) => u.unitId === unit.unitId);
    if (index !== -1) {
      this.remainingMoney += this.cart.units[index].count * unit.price;
      this.cart.units[index].count = unit.count;
      this.remainingMoney -= unit.count * unit.price;
    } else {
      this.remainingMoney -= unit.count * unit.price;
      this.cart.units.push({ unitId: unit.unitId, count: unit.count });
    }
  }

  isCartEmpty(): boolean {
    let sum = 0;
    this.cart.units.forEach((unit) => {
      sum += unit.count;
    });

    return !sum;
  }

  onBuy(): void {
    this.justBoughtUnits$.next(true);
    console.log(this.cart);
    this.battleService.buyUnits(this.cart).subscribe(
      (r) => {
        this.store.dispatch(GetResources);
      },
      (e) => console.error(e)
    );
  }
}
