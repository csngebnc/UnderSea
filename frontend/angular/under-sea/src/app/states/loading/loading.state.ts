import { State, Selector, Action, StateContext } from '@ngxs/store';
import { Injectable } from '@angular/core';
import { SetLoading, SetNotLoading } from './loading.actions';

@State<number>({
  name: 'loadingState',
  defaults: 0,
})
@Injectable()
export class LoadingState {
  @Selector()
  static isLoading(state: number): boolean {
    return state !== 0;
  }

  constructor() {}

  @Action(SetLoading)
  setLoading(store: StateContext<number>) {
    const current = store.getState();
    store.setState(current + 1);
  }

  @Action(SetNotLoading)
  setNotLoading(store: StateContext<number>) {
    const current = store.getState();
    store.setState(current - 1);
  }
}
