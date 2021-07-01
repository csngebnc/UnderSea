import { Resource } from './resource.model';

export type Resources = {
  units: Array<Resource>;
  buildings: Array<Resource>;
  buildingsUnderConstruction: Array<Resource>;
  shells: number;
  shellsPerRound: number;
  corals: number;
  coralsPerRound: number;
};
