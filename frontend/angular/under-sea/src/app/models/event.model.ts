import { Effect } from './effect.model';

export type Event = {
  id: number;
  name: string;
  eventRound: number;
  effects: Array<Effect>;
};
