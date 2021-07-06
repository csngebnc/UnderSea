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
import { Unit } from 'src/app/models/unit.model';
import { Material } from 'src/app/models/material.model';

@State<ResourcesStateModel>({
  name: 'resourcesState',
  defaults: {
    resources: {
      units: [],
      buildings: [],
      materials: [],
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
    return state.resources.materials.find((m) => m.id === 1).count;
  }

  @Selector()
  static materials(state: ResourcesStateModel): Array<Material> {
    return state.resources.materials;
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

  @Selector()
  static units(state: ResourcesStateModel): Array<Unit> {
    return state.resources.units;
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
  }

  @Action(DecrementCapacity)
  decrementCapacity(store: StateContext<ResourcesStateModel>) {
    const value = store.getState().capacity;
    store.patchState({ capacity: value - 1 });
  }
}
