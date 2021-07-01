import { Action, NgxsOnInit, Selector, State, StateContext } from '@ngxs/store';
import { Resources } from 'src/app/models/resources.model';
import { Injectable } from '@angular/core';
import { GetResources } from './resources.actions';
import { ApiService } from 'src/app/services/api/api.service';
import { tap } from 'rxjs/operators';

@State<Resources>({
  name: 'resourcesState',
  defaults: {
    units: [],
    buildings: [],
    pearls: 0,
    corals: 0,
    pearlsPerRound: 0,
    coralsPerRound: 0,
    hasSonar: false,
  },
})
@Injectable()
export class ResourcesState implements NgxsOnInit {
  @Selector()
  static pearls(state: Resources): number {
    return state.pearls;
  }

  constructor(private apiService: ApiService) {}

  ngxsOnInit({ dispatch }: StateContext<Resources>) {
    dispatch(GetResources);
  }

  @Action(GetResources)
  getResources({ setState }: StateContext<Resources>) {
    return this.apiService.getDetails().pipe(tap((r) => setState(r)));
  }
}
