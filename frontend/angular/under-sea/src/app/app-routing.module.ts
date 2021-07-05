import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './pages/authentication/login/login.component';
import { RegisterComponent } from './pages/authentication/register/register.component';
import { MainComponent } from './pages/main/main.component';
import { BuildingsComponent } from './components/buildings/buildings.component';
import { AttackComponent } from './components/attack/attack.component';
import { UpgradesComponent } from './components/upgrades/upgrades.component';
import { ScoreboardComponent } from './components/scoreboard/scoreboard.component';
import { UnitsComponent } from './components/units/units.component';
import { ProfileComponent } from './components/profile/profile.component';

import { AuthGuard } from './guards/auth/auth.guard';
import { ExploreComponent } from './components/explore/explore.component';
import { ReportsComponent } from './components/reports/reports.component';
import { BattleComponent } from './components/battle/battle.component';
import { ExploreListComponent } from './components/explore-list/explore-list.component';

const routes: Routes = [
  {
    path: 'login',
    component: LoginComponent,
  },
  {
    path: 'register',
    component: RegisterComponent,
  },
  {
    path: 'main',
    component: MainComponent,
    canActivate: [AuthGuard],
    canActivateChild: [AuthGuard],
    children: [
      {
        path: 'buildings',
        component: BuildingsComponent,
      },
      {
        path: 'attack',
        component: AttackComponent,
      },
      {
        path: 'upgrades',
        component: UpgradesComponent,
      },
      {
        path: 'reports',
        component: ReportsComponent,
        children: [
          {
            path: 'battle',
            component: BattleComponent,
          },
          {
            path: 'explore',
            component: ExploreListComponent,
          },
        ],
      },
      {
        path: 'scoreboard',
        component: ScoreboardComponent,
      },
      {
        path: 'units',
        component: UnitsComponent,
      },
      {
        path: 'profile',
        component: ProfileComponent,
      },
      {
        path: 'explore',
        component: ExploreComponent,
      },
    ],
  },
  {
    path: '**',
    redirectTo: 'main',
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
