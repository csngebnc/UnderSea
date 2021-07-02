import { FightOutcome } from '../services/generated-code/generated-api-code';

export type Battle = {
  target: string;
  result?: FightOutcome;
  units: Array<{ count: number; name: string }>;
};
