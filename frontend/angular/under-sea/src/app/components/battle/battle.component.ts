import { Component, OnInit } from '@angular/core';
import { BattleService } from 'src/app/services/battle/battle.service';
import { PagedBattles } from 'src/app/models/paged-battles.model';
import { BehaviorSubject } from 'rxjs';

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

  isLoading = new BehaviorSubject(false);

  constructor(private battleService: BattleService) {}

  ngOnInit(): void {
    this.initBattles();
  }

  initBattles() {
    this.isLoading.next(true);
    this.battleService.getBattles(this.pagedBattles.pageNumber).subscribe(
      (r) => {
        this.pagedBattles = r;
        this.isLoading.next(false);
      },
      (e) => console.log(e)
    );
  }

  onSwitchPage(pageNumber: number): void {
    this.pagedBattles.pageNumber = pageNumber;
    this.initBattles();
  }
}
