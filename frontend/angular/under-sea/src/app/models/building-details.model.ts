import { Effect } from './effect.model';

export type BuildingDetails = {
  id: number;
  name: string;
  effects: Array<Effect>;
  underConstruction: boolean;
  count: number;
  price: number;
  imageUrl?: string;
};
