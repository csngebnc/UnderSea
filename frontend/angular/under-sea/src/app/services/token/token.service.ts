import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class TokenService {
  constructor() {}

  private token: string = '';

  getToken(): string {
    return this.token;
  }

  loadToken(): void {
    const lst = localStorage.getItem('token');
    if (lst) this.token = lst;
  }

  setToken(token: string): void {
    localStorage.setItem('token', token);
    this.token = token;
  }

  deleteToken(): void {
    localStorage.removeItem('token');
  }

  isTokenValid(): boolean {
    if (!this.token) return false;
    const arr = this.token.split('.');

    const decoded = JSON.parse(atob(arr[1]));

    const exp: Date = new Date(0);
    exp.setUTCSeconds(decoded['exp']);

    return exp.getTime() > new Date().getTime();
  }
}
