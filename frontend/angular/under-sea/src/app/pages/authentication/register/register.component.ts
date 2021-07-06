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
import { BehaviorSubject } from 'rxjs';
import { HttpError } from '@microsoft/signalr';

@Component({
  selector: 'register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss'],
})
export class RegisterComponent implements OnInit {
  private pwRegEx = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[._#$^+=!*()@%&]).{6,}$/;
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
    ]),
    confirmPassword: new FormControl('', [
      Validators.required,
      this.doPasswordsMatch(),
    ]),
    countryName: new FormControl('', [
      Validators.required,
      Validators.pattern(this.countryRegex),
    ]),
  });

  regFailed = new BehaviorSubject(false);

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
        this.setFormInvalid(e);
      }
    );
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

  private setFormInvalid(e: HttpError): void {
    //itt elvileg más hibák is lesznek, majd a backend küldi miért lett rossz a reg
    this.regFailed.next(true);
    this.registerForm.controls['userName'].setErrors({ invalid: true });
  }
}
