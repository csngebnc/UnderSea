import { Effect } from './effect.model';

export type BuildingDetails = {
  id: number;
  name: string;
  effects: Array<Effect>;
  count: number;
  price: number;
};
