import { Component, OnInit } from '@angular/core';
import { UserService } from 'src/app/services/user/user.service';
import { FormGroup, FormControl, Validators } from '@angular/forms';

@Component({
  selector: 'profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss'],
})
export class ProfileComponent implements OnInit {
  name: string = '';
  private countryRegex = /^(?!\s*$).+/;

  countryForm = new FormGroup({
    newName: new FormControl('', [
      Validators.required,
      Validators.pattern(this.countryRegex),
    ]),
  });

  constructor(private userService: UserService) {}

  ngOnInit(): void {
    this.getName();
  }

  private getName(): void {
    this.userService.getCountryName().subscribe(
      (response) => {
        this.name = response;
      },
      (e) => console.log(e)
    );
  }

  setNewName(): void {
    this.userService
      .setCountryName(this.countryForm.get('newName').value)
      .subscribe(
        () => this.getName(),
        (e) => console.log(e)
      );
  }
}
