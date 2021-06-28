import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'pager-buttons',
  templateUrl: './pager-buttons.component.html',
  styleUrls: ['./pager-buttons.component.scss'],
})
export class PagerButtonsComponent implements OnInit {
  @Input() pageNumber: number;
  @Input() pageSize: number;
  @Input() allResultsCount: number;
  @Output() switchPage = new EventEmitter<number>();

  constructor() {}

  ngOnInit(): void {}

  onClick(page: number): void {
    this.switchPage.emit(page);
  }
}
