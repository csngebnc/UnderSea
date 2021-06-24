import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
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
    ListComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
