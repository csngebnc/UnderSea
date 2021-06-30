import { Component, OnInit } from '@angular/core';
import { UnitDetails } from 'src/app/models/unit-details.model';
import { UnitsDto } from 'src/app/models/dto/units-dto.model';
import { CartUnit } from 'src/app/models/cart-unit.model';
import { BattleService } from 'src/app/services/battle/battle.service';
import { BehaviorSubject, forkJoin } from 'rxjs';
import { UserService } from 'src/app/services/user/user.service';

@Component({
  selector: 'units',
  templateUrl: './units.component.html',
  styleUrls: ['./units.component.scss'],
})
export class UnitsComponent implements OnInit {
  units: Array<UnitDetails> = [];
  cart: Array<UnitsDto> = [];
  money: number;
  remainingMoney: number;

  isLoading = new BehaviorSubject(false);

  constructor(
    private battleService: BattleService,
    private userService: UserService
  ) {}

  ngOnInit(): void {
    this.initUnits();
  }

  private initUnits(): void {
    this.isLoading.next(true);

    let units = this.battleService.getUnits();
    let pearls = this.userService.getPearlCount();

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
      this.cart.push({ id: unit.id, count: 0 });
    });
  }

  addToCart(unit: CartUnit): void {
    let index = this.cart.findIndex((u) => u.id === unit.id);
    if (index !== -1) {
      this.remainingMoney += this.cart[index].count * unit.price;
      this.cart[index].count = unit.count;
      this.remainingMoney -= unit.count * unit.price;
    }
  }

  isCartEmpty(): boolean {
    let sum = 0;
    this.cart.forEach((unit) => {
      sum += unit.count;
    });

    return !sum;
  }

  onBuy(): void {
    console.log(JSON.stringify(this.cart));
  }
}
