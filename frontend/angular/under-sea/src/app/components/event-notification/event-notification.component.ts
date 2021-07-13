import { Event } from './../../models/event.model';
import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'event-notification',
  templateUrl: './event-notification.component.html',
  styleUrls: ['./event-notification.component.scss'],
})
export class EventNotificationComponent implements OnInit {
  @Input() event: Event;
  @Output() notificationClosed = new EventEmitter<void>();

  constructor() {}

  ngOnInit(): void {}
}
