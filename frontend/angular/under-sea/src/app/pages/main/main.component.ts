import { Component, OnInit } from '@angular/core';
import { UserData } from 'src/app/models/userdata.model';
import { Resources } from 'src/app/models/resources.model';
import { Observable } from 'rxjs';
import { SignalRService } from 'src/app/services/signalr/signalr.service';
import { Store, Select } from '@ngxs/store';
import { GetResources } from 'src/app/states/resources/resources.actions';
import { ResourcesState } from 'src/app/states/resources/resources.state';
import { UserDataState } from 'src/app/states/user-data/user-data.state';
import { GetUserData } from 'src/app/states/user-data/user-data.actions';

@Component({
  selector: 'main',
  templateUrl: './main.component.html',
  styleUrls: ['./main.component.scss'],
})
export class MainComponent implements OnInit {
  @Select(ResourcesState.allResources)
  resources: Observable<Resources>;

  @Select(UserDataState.userData)
  userData: Observable<UserData>;

  constructor(private signalr: SignalRService, private store: Store) {
    this.signalr.startConnection();
    this.signalr.hubConnection.on('SendMessage', () => {
      this.loadResources();
    });
  }

  ngOnInit(): void {
    this.loadResources();
  }

  private loadResources(): void {
    this.store.dispatch(GetResources);
    this.store.dispatch(GetUserData);
  }
}
