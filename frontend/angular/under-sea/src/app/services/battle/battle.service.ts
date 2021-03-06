import { UnitLevel } from './../../models/unit-level.model';
import { Material } from './../../models/material.model';
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
import { PagedSpyReport } from 'src/app/models/paged-spy-report.model';

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
          const materials: Array<Material> = u.requiredMaterials.map((m) => {
            return {
              id: m.id,
              count: m.amount,
              imageUrl: m.imageUrl,
              name: m.name,
            };
          });

          const stats: Array<UnitLevel> = u.unitLevels.map((l) => {
            return {
              attackPoint: l.attackPoint,
              defensePoint: l.defensePoint,
              level: l.level,
            };
          });
          result.push({
            id: u.id,
            name: u.name,
            count: u.currentCount,
            stats,
            mercenary: u.mercenaryPerRound,
            supply: u.supplyPerRound,
            price: materials,
            icon: u.imageUrl,
          });
        });
        return result;
      })
    );
  }

  getBattles(pageNumber: number): Observable<PagedBattles> {
    return this.battleService.history(10, pageNumber).pipe(
      map((r: PagedResultOfLoggedAttackDto) => {
        const result: PagedBattles = {
          battles: [],
          pageNumber: 1,
          pageSize: 0,
          allResultsCount: 0,
        };
        result.pageNumber = r.pageNumber;
        result.pageSize = r.pageSize;
        result.allResultsCount = r.allResultsCount;

        r.results.forEach((b) => {
          const units = [];
          b.units.forEach((u) => {
            if (!units.find((unit) => unit.name === u.name)) {
              units.push({ name: u.name, count: 0, levels: [] });
            }
          });

          b.units.forEach((u) => {
            const index = units.findIndex((unit) => unit.name === u.name);
            if (index !== -1) {
              units[index].count = u.count + units[index].count;
              units[index].levels.push({ count: u.count, level: u.level });
            }
          });

          result.battles.push({
            target: b.attackedCountryName,
            result: b.outcome,
            units,
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
          pageNumber: arr.pageNumber,
          pageSize: arr.pageSize,
          allResultsCount: arr.allResultsCount,
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
    return this.battleService.attack({ attackedCountryId: id, units });
  }

  buyUnits(units: BuyUnitDto): Observable<any> {
    return this.battleService.buyUnit(units);
  }

  getSpies(): Observable<AttackerUnit> {
    return this.battleService.spies().pipe(
      map((r) => {
        return r as AttackerUnit;
      })
    );
  }

  spy(id: number, count: number): Observable<any> {
    return this.battleService.spy({ spiedCountryId: id, spyCount: count });
  }

  getExplorations(pageNumber: number): Observable<PagedSpyReport> {
    return this.battleService.spyHistory(10, pageNumber).pipe(
      map((r) => {
        const result: PagedSpyReport = {
          reports: [],
          pageNumber: r.pageNumber,
          pageSize: r.pageSize,
          allResultsCount: r.allResultsCount,
        };

        r.results.forEach((i) => {
          result.reports.push({
            country: i.spiedCountryName,
            outcome: i.outCome,
            defense: i.defensePoints,
          });
        });

        return result;
      })
    );
  }
}
