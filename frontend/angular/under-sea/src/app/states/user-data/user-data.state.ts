import { Action, NgxsOnInit, Selector, State, StateContext } from '@ngxs/store';
import { Injectable } from '@angular/core';
import { GetUserData } from './user-data.actions';
import { ApiService } from 'src/app/services/api/api.service';
import { tap } from 'rxjs/operators';
import { UserData } from 'src/app/models/userdata.model';

@State<UserData>({
  name: 'userDataState',
  defaults: { name: '', placement: 0, round: 0 },
})
@Injectable()
export class UserDataState implements NgxsOnInit {
  @Selector()
  static userData(state: UserData): UserData {
    return state;
  }

  constructor(private apiService: ApiService) {}

  ngxsOnInit({ dispatch }: StateContext<UserData>) {}

  @Action(GetUserData)
  getResources({ setState }: StateContext<UserData>) {
    return this.apiService.getUser().pipe(tap((u) => setState(u)));
  }
}
