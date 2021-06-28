import { Effect } from './effect.model';

export type Upgrade = {
  id: number;
  name: string;
  doesExist: boolean;
  isUnderConstruction: boolean;
  remainingTime?: number;
  effects: Array<Effect>;
};
