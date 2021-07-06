import { Material } from './material.model';
import { Unit } from './unit.model';
import { Building } from './building.model';

export type Resources = {
  units: Array<Unit>;
  buildings: Array<Building>;
  materials: Array<Material>;
  hasSonar: boolean;
  maxUnitCount: number;
};
