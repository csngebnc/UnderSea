import { UserListItem } from './userlist-item.model';

export type PagedList = {
  list: Array<UserListItem>;
  pageNumber: number;
  pageSize: number;
  allResultsCount: number;
};
