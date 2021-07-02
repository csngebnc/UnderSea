import { Component, OnInit } from '@angular/core';
import { UserData } from 'src/app/models/userdata.model';
import { Resources } from 'src/app/models/resources.model';
import { BehaviorSubject, Observable } from 'rxjs';
import { SignalRService } from 'src/app/services/signalr/signalr.service';
import { Store, Select } from '@ngxs/store';
import { GetResources } from 'src/app/states/resources/resources.actions';
import { ResourcesState } from 'src/app/states/resources/resources.state';
import { UserDataState } from 'src/app/states/user-data/user-data.state';
import { GetUserData } from 'src/app/states/user-data/user-data.actions';
import { ResourcesStateModel } from 'src/app/models/states/resources-state.model';

@Component({
  selector: 'main',
  templateUrl: './main.component.html',
  styleUrls: ['./main.component.scss'],
})
export class MainComponent implements OnInit {
  @Select(ResourcesState.allResources)
  private resourcesState: Observable<Resources>;

  @Select(UserDataState.userData)
  private userDataState: Observable<UserData>;

  isLoading = new BehaviorSubject(false);

  resources: Resources | null = null;

  userData: UserData | null = null;
  constructor(private signalr: SignalRService, private store: Store) {
    this.signalr.startConnection();
    this.resourcesState.subscribe((r) => (this.resources = r));
    this.userDataState.subscribe((u) => (this.userData = u));
    this.signalr.hubConnection.on('SendMessage', (round: number) => {
      console.log(round);
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
