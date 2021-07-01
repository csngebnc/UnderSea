import { Component, OnInit } from '@angular/core';
import { UserService } from 'src/app/services/user/user.service';
import { PagedList } from 'src/app/models/paged-list.model';
import { BehaviorSubject } from 'rxjs';

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

  isLoading = new BehaviorSubject(false);
  filter: string | undefined = undefined;
  constructor(private userService: UserService) {}

  ngOnInit(): void {
    this.initScoreBoard();
  }

  private initScoreBoard(): void {
    this.isLoading.next(true);
    this.userService
      .getScoreBoard(this.scoreboard.pageNumber, this.filter)
      .subscribe(
        (r: PagedList) => {
          this.scoreboard = r;
          this.isLoading.next(false);
        },
        (e) => console.log(e)
      );
  }

  onFilter(s: string): void {
    if (s) this.filter = s;
    else this.filter = undefined;
    this.scoreboard.pageNumber = 1;
    this.initScoreBoard();
  }

  onSwitchPage(pageNumber: number): void {
    this.scoreboard.pageNumber = pageNumber;
    this.initScoreBoard();
  }
}
