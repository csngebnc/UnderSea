import { Unit } from './unit.model';
import { Building } from './building.model';

export type Resources = {
  units: Array<Unit>;
  buildings: Array<Building>;
  pearls: number;
  pearlsPerRound: number;
  corals: number;
  coralsPerRound: number;
};
