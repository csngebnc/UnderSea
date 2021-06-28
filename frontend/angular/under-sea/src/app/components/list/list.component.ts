import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { UserListItem } from '../../models/userlist-item.model';

@Component({
  selector: 'list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.scss'],
})
export class ListComponent implements OnInit {
  @Input() list: Array<UserListItem>;
  @Input() clickable?: boolean;
  @Output() selectTarget = new EventEmitter<number>();
  selectedTargetId: number | null = null;

  constructor() {}

  ngOnInit(): void {}

  onSelect(id: number): void {
    this.selectedTargetId = id;
    this.selectTarget.emit(this.selectedTargetId);
  }
}
