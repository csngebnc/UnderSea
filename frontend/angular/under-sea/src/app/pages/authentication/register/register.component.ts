import { Component, OnInit } from '@angular/core';
import { AuthenticationService } from 'src/app/services/authentication/authentication.service';

import {
  FormControl,
  FormGroup,
  Validators,
  ValidationErrors,
  AbstractControl,
  ValidatorFn,
} from '@angular/forms';
import { RegisterDto } from 'src/app/models/dto/register-dto.model';

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

  constructor(private authService: AuthenticationService) {}

  ngOnInit(): void {}

  onSubmit(): void {
    const data: RegisterDto = {
      userName: this.registerForm.value.userName,
      password: this.registerForm.value.password,
      confirmPassword: this.registerForm.value.confirmPassword,
      countryName: this.registerForm.value.countryName,
    };
    this.authService.register(data);
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
      if (fg) {
        const matching = control.value === fg.controls['password'].value;
        return matching ? null : { passwordMismatch: true };
      }
      return null;
    };
  }
}
