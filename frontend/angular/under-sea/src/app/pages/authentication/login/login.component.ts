import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { AuthenticationService } from 'src/app/services/authentication/authentication.service';
import { TokenService } from 'src/app/services/token/token.service';
import { Token } from '@angular/compiler/src/ml_parser/lexer';

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

  constructor(
    private authService: AuthenticationService,
    private tokenService: TokenService
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
          console.log(this.tokenService.getToken());
          console.log(this.tokenService.isTokenValid());
        },
        (error) => {
          console.log(error);
        }
      );
  }
}
