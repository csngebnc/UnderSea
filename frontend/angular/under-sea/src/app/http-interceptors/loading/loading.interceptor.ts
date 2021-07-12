import { Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor,
} from '@angular/common/http';
import { Observable } from 'rxjs';
import { Store } from '@ngxs/store';
import { loadingWhitelist as whitelist, apiUrl } from 'src/assets/config.json';
import {
  SetLoading,
  SetNotLoading,
} from 'src/app/states/loading/loading.actions';
import { finalize } from 'rxjs/operators';

@Injectable()
export class LoadingInterceptor implements HttpInterceptor {
  constructor(private store: Store) { }

  intercept(
    request: HttpRequest<unknown>,
    next: HttpHandler
  ): Observable<HttpEvent<unknown>> {
    if (this.isUrlOnWhiteList(request.url, whitelist)) {
      return next.handle(request);
    }

    Promise.resolve(null).then(() => {
      this.store.dispatch(SetLoading);
    });
    return next.handle(request).pipe(
      finalize(() => {
        this.store.dispatch(SetNotLoading);
      })
    );
  }

  private isUrlOnWhiteList(url: string, wl: Array<string>): boolean {
    return wl.some(
      (path) => url.toLowerCase() === apiUrl + path.toLowerCase()
    );
  }
}
