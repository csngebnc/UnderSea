import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss'],
})
export class ProfileComponent implements OnInit {
  newName: string = '';

  constructor() {}

  ngOnInit(): void {}

  setNewName() {
    console.log(this.newName);
  }
}
