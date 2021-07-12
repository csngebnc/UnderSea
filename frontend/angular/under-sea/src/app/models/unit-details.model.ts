import { UnitLevel } from './unit-level.model';
import { Material } from './material.model';

export type UnitDetails = {
  id: number;
  name: string;
  count: number;
  stats: Array<UnitLevel>;
  mercenary: number;
  supply: number;
  price: Array<Material>;
  icon?: string;
};
