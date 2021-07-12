import { WorldWinner } from './../../models/worldwinner.model';
import { PagedWinners } from './../../models/paged-winners.model';
import { Injectable } from '@angular/core';
import {
  UserService as uService,
  UserRankDto,
} from '../generated-code/generated-api-code';
import { map } from 'rxjs/operators';
import { Observable } from 'rxjs';
import { PagedList } from 'src/app/models/paged-list.model';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  constructor(private userService: uService) {}

  getScoreBoard(
    pageNumber: number,
    filter: string | undefined
  ): Observable<PagedList> {
    if (!filter) filter = undefined;
    return this.userService.ranklist(10, pageNumber, filter).pipe(
      map((r) => {
        const result: PagedList = {
          list: [],
          pageNumber: 1,
          pageSize: 0,
          allResultsCount: 0,
        };

        result.pageNumber = r.pageNumber;
        result.pageSize = r.pageSize;
        result.allResultsCount = r.allResultsCount;

        if (r.results) {
          r.results.forEach((u: UserRankDto, index) =>
            result.list.push({
              placement: u.placement,
              name: u.name,
              score: u.points,
            })
          );
        }

        return result;
      })
    );
  }

  getWinners(
    pageNumber: number,
    filter: string | undefined
  ): Observable<PagedWinners> {
    return this.userService.worldwinners(10, pageNumber, filter).pipe(
      map((w) => {
        const result: PagedWinners = {
          pageSize: w.pageSize,
          pageNumber: w.pageNumber,
          allResultsCount: w.allResultsCount,
          winners: [],
        };

        w.results.forEach((r) => {
          result.winners.push(r as WorldWinner);
        });

        return result;
      })
    );
  }
}
