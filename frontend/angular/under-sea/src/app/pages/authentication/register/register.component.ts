import { Component, OnInit } from '@angular/core';
import {
  FormControl,
  FormGroup,
  Validators,
  ValidationErrors,
  AbstractControl,
  ValidatorFn,
  Validator,
} from '@angular/forms';

@Component({
  selector: 'register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss'],
})
export class RegisterComponent implements OnInit {
  private pwRegEx = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[._#$^+=!*()@%&]).{6,}$/;
  registerForm = new FormGroup({
    userName: new FormControl('', Validators.required),
    password: new FormControl('', [
      Validators.required,
      Validators.minLength(6),
      this.passwordRequirementValidator(this.pwRegEx),
    ]),
    confirmPassword: new FormControl('', [
      Validators.required,
      this.doPasswordsMatch(),
    ]),
    countryName: new FormControl('', Validators.required),
  });

  constructor() {}

  ngOnInit(): void {}

  onSubmit(): void {
    console.log(this.registerForm.value);
  }

  private passwordRequirementValidator(pwRe: RegExp): ValidatorFn {
    return (control: AbstractControl): ValidationErrors | null => {
      const correct = pwRe.test(control.value);
      return correct ? null : { invalidPassword: true };
    };
  }

  private doPasswordsMatch(): ValidatorFn {
    return (control: AbstractControl): ValidationErrors | null => {
      const fg = control.parent;
      console.log(fg.get('controls'));
      return null;
    };
  }
}
