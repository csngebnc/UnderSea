import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { RegisterDto } from 'src/app/models/dto/register-dto.model';
import * as config from 'src/assets/config.json';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class AuthenticationService {
  constructor(private http: HttpClient) {}

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

  register(data: RegisterDto): void {
    this.http
      .post('https://api-undersea.azurewebsites.net/api/user/register', data)
      .subscribe(
        (r) => console.log(r),
        (error) => console.log('baj van', error)
      );
  }
}
