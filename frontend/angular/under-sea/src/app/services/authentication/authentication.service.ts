import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import * as config from 'src/assets/config.json';
import { Observable } from 'rxjs';
import {
  UserService,
  API_BASE_URL,
  RegisterDto,
} from '../generated-code/generated-api-code';
import { Router } from '@angular/router';
import { TokenService } from '../token/token.service';

@Injectable({
  providedIn: 'root',
})
export class AuthenticationService {
  constructor(
    private http: HttpClient,
    private userService: UserService,
    private router: Router,
    private tokenService: TokenService
  ) {}

  login(userName: string, password: string): Observable<any> {
    let body = new URLSearchParams();
    body.set('username', userName);
    body.set('password', password);
    body.set('grant_type', 'password');
    body.set('client_id', 'undersea-angular');
    body.set('scope', 'openid api-openid');

    let options = {
      headers: new HttpHeaders().set(
        'Content-Type',
        'application/x-www-form-urlencoded'
      ),
    };

    return this.http.post(
      `${config.apiUrl}/connect/token`,
      body.toString(),
      options
    );
  }

  register(data: RegisterDto): Observable<string> {
    return this.userService.register(data);
  }

  logout(): void {
    this.tokenService.deleteToken();
    this.router.navigate(['login']);
  }
}
