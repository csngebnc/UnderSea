import { ToastrService } from 'ngx-toastr';
import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { CountryService } from 'src/app/services/country/country.service';
import { LoadingState } from 'src/app/states/loading/loading.state';
import { Observable } from 'rxjs';
import { Select } from '@ngxs/store';

@Component({
  selector: 'profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss'],
})
export class ProfileComponent implements OnInit {
  name: string = '';
  private countryRegex = /^(?!\s*$).+/;

  @Select(LoadingState.isLoading)
  loading$: Observable<boolean>;

  countryForm = new FormGroup({
    newName: new FormControl('', [
      Validators.required,
      Validators.pattern(this.countryRegex),
    ]),
  });

  constructor(
    private countryService: CountryService,
    private toastr: ToastrService
  ) {}

  ngOnInit(): void {
    this.getName();
  }

  private getName(): void {
    this.countryService.getCountryName().subscribe(
      (response) => {
        this.name = response;
      },
      (e) => {
        const error = JSON.parse(e['response']);
        const errorText = Object.values(error['errors'])[0][0];
        this.toastr.error(errorText);
      }
    );
  }

  setNewName(): void {
    this.countryService
      .setCountryName(this.countryForm.get('newName').value)
      .subscribe(
        () => this.getName(),
        (e) => {
          const error = JSON.parse(e['response']);
          const errorText = Object.values(error['errors'])[0][0];
          this.toastr.error(errorText);
        }
      );
  }
}
