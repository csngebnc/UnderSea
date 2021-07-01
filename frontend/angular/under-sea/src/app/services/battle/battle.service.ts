import { Injectable } from '@angular/core';
import {
  BattleService as bService,
  UnitDto,
  PagedResultOfLoggedAttackDto,
  PagedResultOfAttackableUserDto,
  BattleUnitDto,
  AttackUnitDto,
  BuyUnitDto,
} from '../generated-code/generated-api-code';
import { Observable } from 'rxjs';
import { UnitDetails } from 'src/app/models/unit-details.model';
import { map } from 'rxjs/operators';
import { PagedBattles } from 'src/app/models/paged-battles.model';
import { PagedList } from 'src/app/models/paged-list.model';
import { AttackerUnit } from 'src/app/models/attacker-unit.model';

@Injectable({
  providedIn: 'root',
})
export class BattleService {
  constructor(private battleService: bService) {}

  getUnits(): Observable<Array<UnitDetails>> {
    return this.battleService.units().pipe(
      map((arr: Array<UnitDto>) => {
        const result: Array<UnitDetails> = [];
        arr.forEach((u: UnitDto) => {
          result.push({
            id: u.id,
            name: u.name,
            count: u.currentCount,
            defense: u.defensePoint,
            attack: u.attackPoint,
            mercenary: u.mercenaryPerRound,
            supply: u.supplyPerRound,
            price: u.price,
          });
        });
        return result;
      })
    );
  }

  getBattles(pageNumber: number): Observable<PagedBattles> {
    return this.battleService.history(13, pageNumber).pipe(
      map((r: PagedResultOfLoggedAttackDto) => {
        let result: PagedBattles = {
          battles: [],
          pageNumber: 1,
          pageSize: 0,
          allResultsCount: 0,
        };

        const outcome = ['Folyamatban', 'Győzelem', 'Vereség'];
        result.pageNumber = r.pageNumber;
        result.pageSize = r.pageSize;
        result.allResultsCount = r.allResultsCount;

        r.results.forEach((b) => {
          const units = [];
          b.units.forEach((u) => {
            units.push({ name: u.name, count: u.count });
          });
          result.battles.push({
            target: b.attackedCountryName,
            result: outcome[b.outcome],
            units: units,
          });
        });

        return result;
      })
    );
  }

  getUsers(
    pageNumber: number,
    filter: string | undefined
  ): Observable<PagedList> {
    return this.battleService.attackableUsers(10, pageNumber, filter).pipe(
      map((arr: PagedResultOfAttackableUserDto) => {
        const result: PagedList = {
          list: [],
          pageNumber: 1,
          pageSize: 0,
          allResultsCount: 0,
        };

        arr.results.forEach((u) =>
          result.list.push({
            id: u.id,
            name: u.userName,
            countryId: u.countryId,
          })
        );

        return result;
      })
    );
  }

  getAttackerUnits(): Observable<Array<AttackerUnit>> {
    return this.battleService.availableUnits().pipe(
      map((arr: Array<BattleUnitDto>) => {
        const result: Array<AttackerUnit> = [];

        arr.forEach((u) => result.push(u as AttackerUnit));

        return result;
      })
    );
  }

  attack(id: number, units: Array<AttackUnitDto>): Observable<any> {
    return this.battleService.attack({ attackedCountryId: id, units: units });
  }

  buyUnits(units: BuyUnitDto): Observable<any> {
    return this.battleService.buyUnit(units);
  }
}
