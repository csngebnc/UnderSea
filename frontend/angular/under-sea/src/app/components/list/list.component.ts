import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { UserListItem } from '../../models/userlist-item.model';
import { debounce } from 'lodash';

@Component({
  selector: 'list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.scss'],
})
export class ListComponent implements OnInit {
  @Input() list: Array<UserListItem>;
  @Input() clickable?: boolean;
  @Input() defaultValue = '';
  @Output() selectTarget = new EventEmitter<number>();
  @Output() filter = new EventEmitter<string>();
  selectedTargetId: number | null = null;

  constructor() {
    this.search = debounce(this.search, 1000);
  }

  ngOnInit(): void {}

  onSelect(id: number): void {
    this.selectedTargetId = id;
    this.selectTarget.emit(this.selectedTargetId);
  }

  search(text: string): void {
    const trimmed = text.trim();
    if (trimmed.length >= 1 || text.length === 0) {
      this.filter.emit(text);
    }
  }
}
