import { Component, OnInit, Input } from '@angular/core';
import { UserListItem } from '../../models/userlist-item.model';

@Component({
  selector: 'list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.scss']
})
export class ListComponent implements OnInit {

  @Input() list: Array<UserListItem>;

  constructor() { }

  ngOnInit(): void {
  }

}
