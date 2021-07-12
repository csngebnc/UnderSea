import { PagedEvents } from 'src/app/models/paged-events.model';
import { EventService } from './../../services/event/event.service';
import { Component, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { Select } from '@ngxs/store';
import { LoadingState } from 'src/app/states/loading/loading.state';
import { Observable } from 'rxjs';

@Component({
  selector: 'events',
  templateUrl: './events.component.html',
  styleUrls: ['./events.component.scss'],
})
export class EventsComponent implements OnInit {
  list: PagedEvents = {
    events: [],
    pageNumber: 1,
    pageSize: 0,
    allResultscount: 0,
  };

  @Select(LoadingState.isLoading)
  loading$: Observable<boolean>;

  constructor(
    private eventService: EventService,
    private toastr: ToastrService
  ) {}

  ngOnInit(): void {
    this.initEvents();
  }

  private initEvents(): void {
    this.eventService.getEvents(this.list.pageNumber).subscribe(
      (r) => {
        this.list = r;
      },
      (e) => {
        const error = JSON.parse(e['response']);
        const errorText = Object.values(error['errors'])[0][0];
        this.toastr.error(errorText);
      }
    );
  }

  onSwitchPage(pageNumber: number): void {
    this.list.pageNumber = pageNumber;
    this.initEvents();
  }
}
