import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './pages/authentication/login/login.component';
import { RegisterComponent } from './pages/authentication/register/register.component';
import { MainComponent } from './pages/main/main.component';
import { BuildingsComponent } from './components/buildings/buildings.component';
import { AttackComponent } from './components/attack/attack.component';
import { UpgradesComponent } from './components/upgrades/upgrades.component';
import { BattleComponent } from './components/battle/battle.component';
import { ScoreboardComponent } from './components/scoreboard/scoreboard.component';
import { UnitsComponent } from './components/units/units.component';
import { ProfileComponent } from './components/profile/profile.component';

import { AuthGuard } from './guards/auth/auth.guard';

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
        path: 'battle',
        component: BattleComponent,
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
