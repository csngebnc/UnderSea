import { Component, OnInit } from '@angular/core';
import { PagedList } from 'src/app/models/paged-list.model';
import { LoadingState } from 'src/app/states/loading/loading.state';
import { Observable } from 'rxjs';
import { Select } from '@ngxs/store';
import { UserService } from 'src/app/services/user/user.service';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-ranklist',
  templateUrl: './ranklist.component.html',
  styleUrls: ['./ranklist.component.scss'],
})
export class RanklistComponent implements OnInit {
  scoreboard: PagedList = {
    list: [],
    pageNumber: 1,
    pageSize: 0,
    allResultsCount: 0,
  };
  filter: string | undefined = undefined;

  @Select(LoadingState.isLoading)
  loading$: Observable<boolean>;

  constructor(
    private userService: UserService,
    private toastr: ToastrService
  ) {}

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
        (e) => {
          const error = JSON.parse(e['response']);
          const errorText = Object.values(error['errors'])[0][0];
          this.toastr.error(errorText);
        }
      );
  }

  onFilter(s: string): void {
    if (s) {
      this.filter = s;
    } else {
      this.filter = undefined;
    }
    this.scoreboard.pageNumber = 1;
    this.initScoreBoard();
  }

  onSwitchPage(pageNumber: number): void {
    this.scoreboard.pageNumber = pageNumber;
    this.initScoreBoard();
  }
}
