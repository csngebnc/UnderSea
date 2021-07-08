import { ToastrService } from 'ngx-toastr';
import { Component, OnInit } from '@angular/core';
import { BattleService } from 'src/app/services/battle/battle.service';
import { PagedBattles } from 'src/app/models/paged-battles.model';
import { FightOutcome } from 'src/app/services/generated-code/generated-api-code';
import { Select } from '@ngxs/store';
import { LoadingState } from 'src/app/states/loading/loading.state';
import { Observable } from 'rxjs';

@Component({
  selector: 'battle',
  templateUrl: './battle.component.html',
  styleUrls: ['./battle.component.scss'],
})
export class BattleComponent implements OnInit {
  pagedBattles: PagedBattles = {
    battles: [],
    pageNumber: 1,
    pageSize: 0,
    allResultsCount: 0,
  };

  @Select(LoadingState.isLoading)
  loading$: Observable<boolean>;

  notYet = FightOutcome.NotPlayedYet;
  lose = FightOutcome.OtherUser;

  constructor(
    private battleService: BattleService,
    private toastr: ToastrService
  ) {}

  ngOnInit(): void {
    this.initBattles();
  }

  initBattles() {
    this.battleService.getBattles(this.pagedBattles.pageNumber).subscribe(
      (r) => {
        this.pagedBattles = r;
      },
      (e) => {
        const error = JSON.parse(e['response']);
        const errorText = Object.values(error['errors'])[0][0];
        this.toastr.error(errorText);
      }
    );
  }

  onSwitchPage(pageNumber: number): void {
    this.pagedBattles.pageNumber = pageNumber;
    this.initBattles();
  }
}
