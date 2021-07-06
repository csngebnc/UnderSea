import { Material } from './material.model';
import { Effect } from './effect.model';

export type BuildingDetails = {
  id: number;
  name: string;
  effects: Array<Effect>;
  underConstruction: boolean;
  count: number;
  price: Array<Material>;
  imageUrl?: string;
};
