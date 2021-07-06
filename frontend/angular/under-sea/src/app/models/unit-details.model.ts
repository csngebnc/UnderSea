import { Material } from './material.model';

export type UnitDetails = {
  id: number;
  name: string;
  count: number;
  attack: number;
  defense: number;
  mercenary: number;
  supply: number;
  price: Array<Material>;
  icon?: string;
};
