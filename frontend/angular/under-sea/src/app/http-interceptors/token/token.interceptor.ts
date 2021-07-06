import { Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor,
} from '@angular/common/http';
import { Observable, EMPTY } from 'rxjs';
import { TokenService } from 'src/app/services/token/token.service';
import { tokenWhitelist as whitelist } from 'src/assets/config.json';
import { AuthenticationService } from 'src/app/services/authentication/authentication.service';

@Injectable()
export class TokenInterceptor implements HttpInterceptor {
  constructor(
    private tokenService: TokenService,
    private authService: AuthenticationService
  ) {}

  intercept(
    request: HttpRequest<unknown>,
    next: HttpHandler
  ): Observable<HttpEvent<unknown>> {
    if (!this.tokenService.isTokenValid()) {
      if (this.isUrlOnWhiteList(request.url, whitelist)) {
        return next.handle(request);
      } else {
        this.authService.logout();
        return EMPTY;
      }
    }

    const token = this.tokenService.getToken();

    const reqWithToken = request.clone({
      setHeaders: {
        Authorization: `Bearer ${token}`,
      },
    });

    return next.handle(reqWithToken);
  }

  private isUrlOnWhiteList(url: string, whitelist: Array<string>): boolean {
    return whitelist.some((path) =>
      url.toLowerCase().includes(path.toLowerCase())
    );
  }
}
