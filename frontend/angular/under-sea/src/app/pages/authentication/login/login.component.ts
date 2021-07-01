import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { AuthenticationService } from 'src/app/services/authentication/authentication.service';
import { TokenService } from 'src/app/services/token/token.service';
import { Router } from '@angular/router';
import { BehaviorSubject } from 'rxjs';

@Component({
  selector: 'login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss'],
})
export class LoginComponent implements OnInit {
  loginForm = new FormGroup({
    userName: new FormControl('', Validators.required),
    password: new FormControl('', [
      Validators.required,
      Validators.minLength(6),
    ]),
  });

  loginFailed = new BehaviorSubject(false);

  constructor(
    private authService: AuthenticationService,
    private tokenService: TokenService,
    private router: Router
  ) {}

  ngOnInit(): void {}

  onSubmit(): void {
    this.authService
      .login(
        this.loginForm.get('userName').value,
        this.loginForm.get('password').value
      )
      .subscribe(
        (r) => {
          this.tokenService.setToken(r['access_token']);
          this.router.navigate(['main']);
        },
        () => {
          this.setFormInvalid();
        }
      );
  }

  private setFormInvalid(): void {
    this.loginFailed.next(true);
    this.loginForm.controls['userName'].setErrors({ incorrect: true });
    this.loginForm.controls['password'].setErrors({ incorrect: true });
  }
}
