import { Battle } from './battle.model';

export type PagedBattles = {
  battles: Array<Battle>;
  pageNumber: number;
  pageSize: number;
  allResultsCount: number;
};
