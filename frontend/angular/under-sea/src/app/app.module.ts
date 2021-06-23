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
    ResourceInfoComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
