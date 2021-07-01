import { Component, OnInit } from '@angular/core';
import { UnitDetails } from 'src/app/models/unit-details.model';
import { CartUnit } from 'src/app/models/cart-unit.model';
import { BattleService } from 'src/app/services/battle/battle.service';
import { BehaviorSubject, forkJoin } from 'rxjs';
import { ApiService } from 'src/app/services/api/api.service';
import { BuyUnitDto } from 'src/app/services/generated-code/generated-api-code';

@Component({
  selector: 'units',
  templateUrl: './units.component.html',
  styleUrls: ['./units.component.scss'],
})
export class UnitsComponent implements OnInit {
  units: Array<UnitDetails> = [];
  cart: BuyUnitDto = { units: [] };
  money: number;
  remainingMoney: number;

  isLoading = new BehaviorSubject(false);

  constructor(
    private battleService: BattleService,
    private apiService: ApiService
  ) {}

  ngOnInit(): void {
    this.initUnits();
  }

  private initUnits(): void {
    this.isLoading.next(true);

    let units = this.battleService.getUnits();
    let pearls = this.apiService.getPearlCount();

    forkJoin([units, pearls]).subscribe(
      (responses) => {
        this.units = responses[0];
        this.initCart();

        this.money = responses[1];
        this.remainingMoney = this.money;

        this.isLoading.next(false);
      },
      (e) => console.log(e)
    );
  }

  private initCart(): void {
    this.units.forEach((unit: UnitDetails) => {
      this.cart.units.push({ unitId: unit.id, count: 0 });
    });
  }

  addToCart(unit: CartUnit): void {
    let index = this.cart.units.findIndex((u) => u.unitId === unit.unitId);
    if (index !== -1) {
      this.remainingMoney += this.cart.units[index].count * unit.price;
      this.cart.units[index].count = unit.count;
      this.remainingMoney -= unit.count * unit.price;
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
    this.battleService.buyUnits(this.cart).subscribe(
      (r) => {
        console.log(r);
      },
      (e) => console.log(e)
    );
  }
}
