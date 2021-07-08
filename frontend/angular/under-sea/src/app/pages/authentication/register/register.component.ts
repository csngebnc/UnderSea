import { Component, OnInit } from '@angular/core';
import { AuthenticationService } from 'src/app/services/authentication/authentication.service';
import { TokenService } from 'src/app/services/token/token.service';
import { Router } from '@angular/router';

import {
  FormControl,
  FormGroup,
  Validators,
  ValidationErrors,
  AbstractControl,
  ValidatorFn,
} from '@angular/forms';

@Component({
  selector: 'register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss'],
})
export class RegisterComponent implements OnInit {
  pwRegEx = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[._#$^+=!*()@%&]).{6,}$/;
  private userNameRegEx = /^[a-zA-Z0-9_@\.\-]*$/;
  private countryRegex = /^(?!\s*$).+/;
  registerForm = new FormGroup({
    userName: new FormControl('', [
      Validators.required,
      Validators.pattern(this.userNameRegEx),
      Validators.minLength(3),
    ]),
    password: new FormControl('', [
      Validators.required,
      Validators.minLength(6),
      Validators.pattern(this.pwRegEx),
      this.doPasswordsMatch('confirmPassword'),
    ]),
    confirmPassword: new FormControl('', [
      Validators.required,
      this.doPasswordsMatch('password'),
    ]),
    countryName: new FormControl('', [
      Validators.required,
      Validators.pattern(this.countryRegex),
    ]),
  });

  regFailed: string;

  constructor(
    private authService: AuthenticationService,
    private tokenService: TokenService,
    private router: Router
  ) {}

  ngOnInit(): void {}

  onSubmit(): void {
    const rf = this.registerForm;
    this.authService.register(rf.value).subscribe(
      (r) => {
        this.authService
          .login(rf.get('userName').value, rf.get('password').value)
          .subscribe((r) => {
            this.tokenService.setToken(r['access_token']);
            this.router.navigate(['main']);
          });
      },
      (e) => {
        this.setFormInvalid(JSON.parse(e['response']));
      }
    );
  }

  private doPasswordsMatch(controlName: string): ValidatorFn {
    return (control: AbstractControl): ValidationErrors | null => {
      const fg = control.parent;
      if (fg) {
        const matching = control.value === fg.controls[controlName].value;
        if (matching || fg.controls[controlName].untouched) {
          fg.controls[controlName].setErrors(null);
          return null;
        } else {
          return { invalid: true };
        }
      }
      return null;
    };
  }

  private setFormInvalid(e: any): void {
    const errors = e['errors'];
    if (errors['userName']) {
      this.registerForm.controls['userName'].setErrors(errors['userName']);
      this.regFailed = errors['userName'];
    }
    if (errors['password']) {
      this.registerForm.controls['password'].setErrors(errors['password']);
      this.regFailed = errors['password'];
    }
    if (errors['confirmPassword']) {
      this.registerForm.controls['confirmPassword'].setErrors(
        errors['confirmPassword']
      );
      this.regFailed = errors['confirmPassword'];
    }
    if (errors['countryName']) {
      this.registerForm.controls['countryName'].setErrors(
        errors['countryName']
      );
      this.regFailed = errors['countryName'];
    }
  }
}
