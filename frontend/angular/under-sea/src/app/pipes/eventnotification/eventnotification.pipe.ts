import { EventService } from './../../services/event/event.service';
import { Event } from './../../models/event.model';
import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'eventnotification',
})
export class EventnotificationPipe implements PipeTransform {
  constructor(private eventService: EventService) {}

  transform(event: Event): boolean {
    if (!event) {
      return false;
    }
    const last = this.eventService.getLastEvent();
    this.eventService.setLastEvent(event.eventRound);
    return last !== event.eventRound;
  }
}
