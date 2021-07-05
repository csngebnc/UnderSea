import { SpyReport } from './spy-report.model';

export type PagedSpyReport = {
  reports: Array<SpyReport>;
  pageNumber: number;
  pageSize: number;
  allResultsCount: number;
};
