import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'events',
  templateUrl: './events.component.html',
  styleUrls: ['./events.component.scss'],
})
export class EventsComponent implements OnInit {
  constructor() {}

  list = ['valami', 'semmi'];
  ngOnInit(): void {}

  onSwitchPage(pageNumber: number): void {
    console.log(pageNumber);
  }
}
