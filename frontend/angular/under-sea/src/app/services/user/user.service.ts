import { Injectable } from '@angular/core';
import {
  UserService as uService,
  CountryDetailsDto,
  PagedResultOfUserRankDto,
  UserRankDto,
} from '../generated-code/generated-api-code';
import { map } from 'rxjs/operators';
import { Resources } from '../../models/resources.model';
import { Observable } from 'rxjs';
import { PagedList } from 'src/app/models/paged-list.model';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  constructor(private userService: uService) {}

  getDetails(): Observable<Resources> {
    return this.userService.details().pipe(
      map((cd: CountryDetailsDto) => {
        return {
          units: cd.units,
          buildings: cd.buildings,
          corals: cd.coral,
          coralsPerRound: cd.currentCoralProduction,
          pearls: cd.pearl,
          pearlsPerRound: cd.currentPearlProduction,
        };
      })
    );
  }

  getCountryName(): Observable<string> {
    return this.userService.countryName();
  }

  setCountryName(name: string): Observable<any> {
    return this.userService.newCountryName(name);
  }

  getScoreBoard(
    pageNumber: number,
    filter: string | undefined
  ): Observable<PagedList> {
    if (!filter) filter = undefined;
    return this.userService.ranklist(10, pageNumber, filter).pipe(
      map((r) => {
        let result: PagedList = {
          list: [],
          pageNumber: 1,
          pageSize: 0,
          allResultsCount: 0,
        };

        result.pageNumber = r.pageNumber;
        result.pageSize = r.pageSize;
        result.allResultsCount = r.allResultsCount;

        if (r.results)
          r.results.forEach((u: UserRankDto, index) =>
            result.list.push({
              placement: (result.pageNumber - 1) * result.pageSize + index + 1,
              name: u.name,
              score: u.points,
            })
          );

        return result;
      })
    );
  }
}
