import { Component, OnInit } from '@angular/core';
import { BattleService } from 'src/app/services/battle/battle.service';
import { PagedSpyReport } from 'src/app/models/paged-spy-report.model';
import { FightOutcome } from 'src/app/services/generated-code/generated-api-code';
import { BehaviorSubject } from 'rxjs';

@Component({
  selector: 'explore-list',
  templateUrl: './explore-list.component.html',
  styleUrls: ['./explore-list.component.scss'],
})
export class ExploreListComponent implements OnInit {
  list: PagedSpyReport = {
    reports: [],
    pageNumber: 1,
    pageSize: 0,
    allResultsCount: 0,
  };

  notYet = FightOutcome.NotPlayedYet;
  noSuccess = FightOutcome.OtherUser;
  success = FightOutcome.CurrentUser;

  isLoading$ = new BehaviorSubject(false);

  constructor(private battleService: BattleService) {}

  ngOnInit(): void {
    this.initExplorations();
  }

  private initExplorations(): void {
    this.isLoading$.next(true);
    this.battleService.getExplorations(this.list.pageNumber).subscribe((r) => {
      this.list = r;
      this.isLoading$.next(false);
    });
  }

  onSwitchPage(pageNumber: number): void {
    this.list.pageNumber = pageNumber;
    this.initExplorations();
  }
}
