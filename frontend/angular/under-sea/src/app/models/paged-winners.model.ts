import { WorldWinner } from './worldwinner.model';

export type PagedWinners = {
  winners: Array<WorldWinner>;
  pageNumber: number;
  pageSize: number;
  allResultsCount: number;
};
