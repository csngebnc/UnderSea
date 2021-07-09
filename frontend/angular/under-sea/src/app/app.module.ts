import { NgModule } from '@angular/core';
import { NgxsModule } from '@ngxs/store';
import { NgxsReduxDevtoolsPluginModule } from '@ngxs/devtools-plugin';

import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import { ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { AppRoutingModule } from './app-routing.module';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { ToastrModule } from 'ngx-toastr';

import { AppComponent } from './app.component';
import { LoginComponent } from './pages/authentication/login/login.component';
import { RegisterComponent } from './pages/authentication/register/register.component';
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

import * as generated from './services/generated-code/generated-api-code';
import { apiUrl } from 'src/assets/config.json';
import { TokenInterceptor } from './http-interceptors/token/token.interceptor';
import { ResourcesState } from './states/resources/resources.state';
import { UserDataState } from './states/user-data/user-data.state';
import { ExploreComponent } from './components/explore/explore.component';
import { ExploreListComponent } from './components/explore-list/explore-list.component';
import { ReportsComponent } from './components/reports/reports.component';
import { LoadingState } from './states/loading/loading.state';
import { LoadingInterceptor } from './http-interceptors/loading/loading.interceptor';
import { HasbuildingPipe } from './pipes/hasbuilding/hasbuilding.pipe';
import { EventsComponent } from './components/events/events.component';
import { EventNotificationComponent } from './components/event-notification/event-notification.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    RegisterComponent,
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
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    HttpClientModule,
    NgxsModule.forRoot([ResourcesState, UserDataState, LoadingState]),
    NgxsReduxDevtoolsPluginModule.forRoot(),
    BrowserAnimationsModule,
    ToastrModule.forRoot({
      timeOut: 4000,
      positionClass: 'toast-top-center',
      preventDuplicates: true,
    }),
  ],
  providers: [
    { provide: generated.API_BASE_URL, useValue: apiUrl },
    generated.UserService,
    generated.ApiService,
    generated.BattleService,
    generated.UpgradeService,
    generated.BuildingService,
    generated.CountryService,
    generated.RoundService,
    { provide: HTTP_INTERCEPTORS, useClass: TokenInterceptor, multi: true },
    { provide: HTTP_INTERCEPTORS, useClass: LoadingInterceptor, multi: true },
  ],
  bootstrap: [AppComponent],
})
export class AppModule { }
