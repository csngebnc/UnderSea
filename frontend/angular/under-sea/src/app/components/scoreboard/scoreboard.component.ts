import { Component, OnInit } from '@angular/core';
import { UserService } from 'src/app/services/user/user.service';
import { PagedList } from 'src/app/models/paged-list.model';
import { LoadingState } from 'src/app/states/loading/loading.state';
import { Select, Store } from '@ngxs/store';
import { Observable } from 'rxjs';

@Component({
  selector: 'scoreboard',
  templateUrl: './scoreboard.component.html',
  styleUrls: ['./scoreboard.component.scss'],
})
export class ScoreboardComponent implements OnInit {
  scoreboard: PagedList = {
    list: [],
    pageNumber: 1,
    pageSize: 0,
    allResultsCount: 0,
  };
  filter: string | undefined = undefined;

  @Select(LoadingState.isLoading)
  loading$: Observable<boolean>;

  constructor(private userService: UserService, private store: Store) { }

  ngOnInit(): void {
    this.initScoreBoard();
  }

  private initScoreBoard(): void {
    this.userService
      .getScoreBoard(this.scoreboard.pageNumber, this.filter)
      .subscribe(
        (r: PagedList) => {
          this.scoreboard = r;
        },
        (e) => console.log(e)
      );
  }

  onFilter(s: string): void {
    if (s) { this.filter = s; }
    else { this.filter = undefined; }
    this.scoreboard.pageNumber = 1;
    this.initScoreBoard();
  }

  onSwitchPage(pageNumber: number): void {
    this.scoreboard.pageNumber = pageNumber;
    this.initScoreBoard();
  }
}
