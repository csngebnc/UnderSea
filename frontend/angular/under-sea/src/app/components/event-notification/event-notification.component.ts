import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'event-notification',
  templateUrl: './event-notification.component.html',
  styleUrls: ['./event-notification.component.scss'],
})
export class EventNotificationComponent implements OnInit {
  event = { name: 'jajj', description: 'this happened' };
  random: number;

  constructor() {
    this.random = Math.ceil(Math.random() * 9);
  }

  ngOnInit(): void {}
}
