import { Action, Selector, State, StateContext } from '@ngxs/store';
import { Resources } from 'src/app/models/resources.model';
import { Injectable } from '@angular/core';
import {
  GetResources,
  IncrementCapacity,
  DecrementCapacity,
} from './resources.actions';
import { ApiService } from 'src/app/services/api/api.service';
import { tap } from 'rxjs/operators';
import { ResourcesStateModel } from 'src/app/models/states/resources-state.model';

@State<ResourcesStateModel>({
  name: 'resourcesState',
  defaults: {
    resources: {
      units: [],
      buildings: [],
      pearls: 0,
      corals: 0,
      pearlsPerRound: 0,
      coralsPerRound: 0,
      hasSonar: false,
      maxUnitCount: 0,
    },
    capacity: 0,
  },
})
@Injectable()
export class ResourcesState {
  @Selector()
  static pearls(state: ResourcesStateModel): number {
    return state.resources.pearls;
  }

  @Selector()
  static maxUnitCount(state: ResourcesStateModel): number {
    return state.resources.maxUnitCount;
  }

  @Selector()
  static remainingCapacity(state: ResourcesStateModel): number {
    return state.capacity;
  }

  @Selector()
  static allResources(state: ResourcesStateModel): Resources {
    return state.resources;
  }

  constructor(private apiService: ApiService) {}

  @Action(GetResources)
  getResources({ setState }: StateContext<ResourcesStateModel>) {
    return this.apiService.getDetails().pipe(
      tap((r) => {
        let sum = 0;
        r.units.forEach((u) => (sum += u.count));
        setState({ resources: r, capacity: r.maxUnitCount - sum });
      })
    );
  }

  @Action(IncrementCapacity)
  incrementCapacity(store: StateContext<ResourcesStateModel>) {
    const value = store.getState().capacity;
    store.patchState({ capacity: value + 1 });
    console.log(store.getState().capacity);
  }

  @Action(DecrementCapacity)
  decrementCapacity(store: StateContext<ResourcesStateModel>) {
    const value = store.getState().capacity;
    store.patchState({ capacity: value - 1 });
    console.log(store.getState().capacity);
  }
}
