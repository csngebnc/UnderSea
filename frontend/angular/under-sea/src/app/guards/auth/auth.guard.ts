import { Injectable } from '@angular/core';
import {
  ActivatedRouteSnapshot,
  CanActivate,
  RouterStateSnapshot,
  CanActivateChild,
} from '@angular/router';
import { TokenService } from '../../services/token/token.service';
import { AuthenticationService } from 'src/app/services/authentication/authentication.service';

@Injectable({
  providedIn: 'root',
})
export class AuthGuard implements CanActivate, CanActivateChild {
  constructor(
    private tokenService: TokenService,
    private autService: AuthenticationService
  ) { }

  canActivate(
  ): boolean {
    return this.validate();
  }

  canActivateChild(
  ): boolean {
    return this.validate();
  }

  private validate(): boolean {
    if (!this.tokenService.isTokenValid()) {
      this.autService.logout();
      return false;
    } else {
      return true;
    }
  }
}
