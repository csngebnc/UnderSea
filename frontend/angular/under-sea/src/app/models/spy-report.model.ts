import { FightOutcome } from '../services/generated-code/generated-api-code';

export type SpyReport = {
  country: string;
  outcome: FightOutcome;
  defense?: number;
};
