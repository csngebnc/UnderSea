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
