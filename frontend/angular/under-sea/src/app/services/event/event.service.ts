import { Effect } from './../../models/effect.model';
import { Observable } from 'rxjs/internal/Observable';
import { EventService as eService } from './../generated-code/generated-api-code';
import { Injectable } from '@angular/core';
import { PagedEvents } from 'src/app/models/paged-events.model';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root',
})
export class EventService {
  constructor(private eventService: eService) {}

  getEvents(pageNumber: number): Observable<PagedEvents> {
    return this.eventService.userEvents(10, pageNumber).pipe(
      map((e) => {
        const result: PagedEvents = {
          pageNumber: e.pageNumber,
          pageSize: e.pageSize,
          allResultscount: e.allResultsCount,
          events: [],
        };

        e.results.forEach((r) => {
          const effects = r.effects.map((f) => f as Effect);

          result.events.push({
            id: r.id,
            eventRound: r.eventRound,
            name: r.name,
            effects,
          });
        });

        return result;
      })
    );
  }

  setLastEvent(round: number): void {
    const last = localStorage.getItem('last_event');
    if (!last || parseInt(last) !== round) {
      localStorage.setItem('last_event', round.toString());
    }
  }

  getLastEvent(): number {
    const lastString = localStorage.getItem('last_event');
    const last = parseInt(lastString);
    if (!last) {
      return -1;
    } else {
      return last;
    }
  }
}
