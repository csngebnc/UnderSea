import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { CountryService } from 'src/app/services/country/country.service';

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

  constructor(private countryService: CountryService) {}

  ngOnInit(): void {
    this.getName();
  }

  private getName(): void {
    this.countryService.getCountryName().subscribe(
      (response) => {
        this.name = response;
      },
      (e) => console.error(e)
    );
  }

  setNewName(): void {
    this.countryService
      .setCountryName(this.countryForm.get('newName').value)
      .subscribe(
        () => this.getName(),
        (e) => console.error(e)
      );
  }
}
