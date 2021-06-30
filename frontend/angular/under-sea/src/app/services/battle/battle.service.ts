import { Injectable } from '@angular/core';
import {
  BattleService as bService,
  UnitDto,
  FightOutcome,
  LoggedAttackDto,
  PagedResultOfUserRankDto,
  PagedResultOfLoggedAttackDto,
} from '../generated-code/generated-api-code';
import { Observable } from 'rxjs';
import { UnitDetails } from 'src/app/models/unit-details.model';
import { map } from 'rxjs/operators';
import { PagedBattles } from 'src/app/models/paged-battles.model';

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
    return this.battleService.history(10, pageNumber).pipe(
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
          result.battles.push({
            target: b.attackedCountryName,
            result: outcome[b.outcome],
            units: b.units,
          });
        });

        return result;
      })
    );
  }
}
