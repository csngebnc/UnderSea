import { Component, OnInit } from '@angular/core';
import { UnitDetails } from 'src/app/models/unit-details.model';
import { UnitsDto } from 'src/app/models/dto/units-dto.model';
import { UnitSliderComponent } from '../unit-slider/unit-slider.component';

@Component({
  selector: 'units',
  templateUrl: './units.component.html',
  styleUrls: ['./units.component.scss'],
})
export class UnitsComponent implements OnInit {
  units: Array<UnitDetails> = [
    {
      id: 'shark',
      name: 'Lézercápa',
      count: 12,
      price: 200,
      mercenary: 10,
      supply: 9,
      attack: 6,
      defense: 6,
    },
    {
      id: 'seal',
      name: 'Rohamfóka',
      count: 12,
      price: 200,
      mercenary: 10,
      supply: 9,
      attack: 6,
      defense: 6,
    },
    {
      id: 'seahorse',
      name: 'Csatacsikó',
      count: 12,
      price: 200,
      mercenary: 10,
      supply: 9,
      attack: 6,
      defense: 6,
    },
  ];

  cart: Array<UnitsDto> = [];
  money: number;
  remainingMoney: number;

  constructor() {
    this.money = 1300;
    this.remainingMoney = this.money;
  }

  ngOnInit(): void {
    this.units.forEach((unit: UnitDetails) => {
      this.cart.push({ id: unit.id, count: 0 });
    });
  }

  addToCart(asd: any): void {
    console.log(asd);

    /*let index = this.cart.findIndex((u) => u.id === id);
    if (index !== -1) {
      this.remainingMoney += this.cart[index].count * price;
      this.cart[index].count = count;
      this.remainingMoney -= count * price;
    }*/
  }

  isCartEmpty(): boolean {
    let sum = 0;
    this.cart.forEach((unit) => {
      sum += unit.count;
    });

    if (!sum) return true;
    else return true;
  }
}
