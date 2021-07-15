import { OAuthService } from 'angular-oauth2-oidc';
import { Component, OnInit } from '@angular/core';
import { Select } from '@ngxs/store';
import { LoadingState } from './states/loading/loading.state';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent implements OnInit {
  @Select(LoadingState)
  loading$: Observable<boolean>;

  title = 'under-sea';

  constructor(private authService: OAuthService) {}

  async ngOnInit(): Promise<void> {
    if (!this.authService.hasValidAccessToken()) {
      this.authService.initCodeFlow();
    }
  }
}
