import { APP_INITIALIZER, NgModule } from '@angular/core';
import { NgxsModule } from '@ngxs/store';
import { NgxsReduxDevtoolsPluginModule } from '@ngxs/devtools-plugin';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import { ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { AppRoutingModule } from './app-routing.module';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { ToastrModule } from 'ngx-toastr';
import { OAuthModule, OAuthService } from 'angular-oauth2-oidc';

import { AppComponent } from './app.component';
import { InfobarComponent } from './components/infobar/infobar.component';
import { SidebarComponent } from './components/sidebar/sidebar.component';
import { ProfilecardComponent } from './components/profilecard/profilecard.component';
import { BuildingContainerComponent } from './components/building-container/building-container.component';
import { MainComponent } from './pages/main/main.component';
import { ResourceInfoComponent } from './components/resource-info/resource-info.component';
import { BuildingsComponent } from './components/buildings/buildings.component';
import { AttackComponent } from './components/attack/attack.component';
import { UpgradesComponent } from './components/upgrades/upgrades.component';
import { BattleComponent } from './components/battle/battle.component';
import { ScoreboardComponent } from './components/scoreboard/scoreboard.component';
import { UnitsComponent } from './components/units/units.component';
import { ProfileComponent } from './components/profile/profile.component';
import { ItemImgComponent } from './components/item-img/item-img.component';
import { BuildingDetailsComponent } from './components/building-details/building-details.component';
import { UpgradeDetailsComponent } from './components/upgrade-details/upgrade-details.component';
import { ListComponent } from './components/list/list.component';
import { UnitDetailsComponent } from './components/unit-details/unit-details.component';
import { UnitSliderComponent } from './components/unit-slider/unit-slider.component';
import { PagerButtonsComponent } from './components/pager-buttons/pager-buttons.component';
import { LoadingComponent } from './components/loading/loading.component';
import { ExploreComponent } from './components/explore/explore.component';
import { ExploreListComponent } from './components/explore-list/explore-list.component';
import { ReportsComponent } from './components/reports/reports.component';
import { EventsComponent } from './components/events/events.component';
import { EventNotificationComponent } from './components/event-notification/event-notification.component';
import { RanklistComponent } from './components/ranklist/ranklist.component';
import { WinnersComponent } from './components/winners/winners.component';

import { ResourcesState } from './states/resources/resources.state';
import { UserDataState } from './states/user-data/user-data.state';
import { LoadingState } from './states/loading/loading.state';

import { LoadingInterceptor } from './http-interceptors/loading/loading.interceptor';
import { HasbuildingPipe } from './pipes/hasbuilding/hasbuilding.pipe';
import { EventnotificationPipe } from './pipes/eventnotification/eventnotification.pipe';

import { environment } from 'src/environments/environment';
import * as generated from './services/generated-code/generated-api-code';
import { apiUrl } from 'src/assets/config.json';

export function initializeApp(oauthService: OAuthService): any {
  return async () => {
    oauthService.configure({
      clientId: 'undersea-angular',
      issuer: apiUrl,
      postLogoutRedirectUri: window.location.origin,
      redirectUri: window.location.origin,
      requireHttps: true,
      responseType: 'code',
      scope: 'openid api-openid',
      useSilentRefresh: true,
      skipIssuerCheck: true,
    });
    oauthService.setupAutomaticSilentRefresh();
    return oauthService.loadDiscoveryDocumentAndTryLogin();
  };
}

@NgModule({
  declarations: [
    AppComponent,
    InfobarComponent,
    SidebarComponent,
    ProfilecardComponent,
    BuildingContainerComponent,
    MainComponent,
    ResourceInfoComponent,
    BuildingsComponent,
    AttackComponent,
    UpgradesComponent,
    BattleComponent,
    ScoreboardComponent,
    UnitsComponent,
    ProfileComponent,
    ItemImgComponent,
    BuildingDetailsComponent,
    UpgradeDetailsComponent,
    ListComponent,
    UnitDetailsComponent,
    UnitSliderComponent,
    PagerButtonsComponent,
    LoadingComponent,
    ExploreComponent,
    ExploreListComponent,
    ReportsComponent,
    HasbuildingPipe,
    EventsComponent,
    EventNotificationComponent,
    EventnotificationPipe,
    RanklistComponent,
    WinnersComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    HttpClientModule,
    NgxsModule.forRoot([ResourcesState, UserDataState, LoadingState], {
      developmentMode: !environment.production,
    }),
    NgxsReduxDevtoolsPluginModule.forRoot(),
    BrowserAnimationsModule,
    ToastrModule.forRoot({
      timeOut: 4000,
      positionClass: 'toast-top-center',
      preventDuplicates: true,
    }),
    OAuthModule.forRoot({
      resourceServer: {
        allowedUrls: [apiUrl],
        sendAccessToken: true,
      },
    }),
  ],
  providers: [
    { provide: generated.API_BASE_URL, useValue: apiUrl },
    {
      provide: APP_INITIALIZER,
      useFactory: initializeApp,
      deps: [OAuthService],
      multi: true,
    },
    generated.UserService,
    generated.ApiService,
    generated.BattleService,
    generated.UpgradeService,
    generated.BuildingService,
    generated.CountryService,
    generated.RoundService,
    generated.EventService,

    {
      provide: HTTP_INTERCEPTORS,
      useClass: LoadingInterceptor,
      multi: true,
    },
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
