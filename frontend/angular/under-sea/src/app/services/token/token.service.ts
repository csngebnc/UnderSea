import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class TokenService {
  constructor() {}

  getToken(): string {
    return localStorage.getItem('token');
  }

  setToken(token: string): void {
    localStorage.setItem('token', token);
  }

  deleteToken(): void {
    localStorage.removeItem('token');
  }

  isTokenValid(): boolean {
    const token = this.getToken();
    if (!token) return false;
    const arr = token.split('.');

    const decoded = JSON.parse(atob(arr[1]));

    const exp: Date = new Date(0);
    exp.setUTCSeconds(decoded['exp']);

    return exp.getTime() > new Date().getTime();
  }
}
