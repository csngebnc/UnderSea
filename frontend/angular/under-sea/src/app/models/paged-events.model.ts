import { Event } from './event.model';

export type PagedEvents = {
  pageNumber: number;
  pageSize: number;
  allResultscount: number;
  events: Array<Event>;
};
