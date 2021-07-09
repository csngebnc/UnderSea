import { Component, OnInit } from '@angular/core';
import { BattleService } from 'src/app/services/battle/battle.service';
import { PagedSpyReport } from 'src/app/models/paged-spy-report.model';
import { FightOutcome } from 'src/app/services/generated-code/generated-api-code';
import { Observable } from 'rxjs';
import { Select } from '@ngxs/store';
import { LoadingState } from 'src/app/states/loading/loading.state';

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

  constructor(private battleService: BattleService) { }

  @Select(LoadingState.isLoading)
  loading$: Observable<boolean>;

  ngOnInit(): void {
    this.initExplorations();
  }

  private initExplorations(): void {
    this.battleService.getExplorations(this.list.pageNumber).subscribe((r) => {
      this.list = r;
    });
  }

  onSwitchPage(pageNumber: number): void {
    this.list.pageNumber = pageNumber;
    this.initExplorations();
  }
}
