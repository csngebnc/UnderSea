import { Effect } from './effect.model';

export type Upgrade = {
  id: number;
  name: string;
  exists: boolean;
  underConstruction: boolean;
  timeRemaining?: number;
  effects: Array<Effect>;
};
