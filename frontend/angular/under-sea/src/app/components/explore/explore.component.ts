import { Component, OnInit } from '@angular/core';
import { forkJoin, Observable } from 'rxjs';
import { BattleService } from 'src/app/services/battle/battle.service';
import { PagedList } from 'src/app/models/paged-list.model';
import { AttackUnitDto } from 'src/app/services/generated-code/generated-api-code';
import { AttackerUnit } from 'src/app/models/attacker-unit.model';
import { Select } from '@ngxs/store';
import { LoadingState } from 'src/app/states/loading/loading.state';

@Component({
  selector: 'explore',
  templateUrl: './explore.component.html',
  styleUrls: ['./explore.component.scss'],
})
export class ExploreComponent implements OnInit {
  spies: AttackerUnit;

  @Select(LoadingState.isLoading)
  loading$: Observable<boolean>;

  players: PagedList = {
    list: [],
    pageNumber: 1,
    pageSize: 0,
    allResultsCount: 0,
  };

  filter: string | undefined = undefined;
  targetId: number;
  selectedCount: number;

  constructor(private battleService: BattleService) {
    this.initExplore();
  }

  ngOnInit(): void {}

  private initPlayers(): void {
    this.battleService.getUsers(this.players.pageNumber, this.filter).subscribe(
      (r) => {
        this.players = r;
      },
      (e) => console.error(e)
    );
  }

  private initExplore(): void {
    this.players.pageNumber = 1;

    let users = this.battleService.getUsers(this.players.pageNumber, undefined);
    let units = this.battleService.getSpies();

    forkJoin([users, units]).subscribe(
      ([users, units]) => {
        this.players = users;
        this.spies = units;
      },
      (e) => console.error(e)
    );
  }

  onSelectTarget(id: number): void {
    this.targetId = id;
  }

  onSetUnit(unit: AttackUnitDto): void {
    this.selectedCount = unit.count;
  }

  onSwitchPage(pageNumber: number): void {
    this.players.pageNumber = pageNumber;
    this.initPlayers();
  }

  onFilter(filter: string): void {
    this.filter = filter;
    this.players.pageNumber = 1;
    this.initPlayers();
  }

  sendSpy(): void {
    this.battleService.spy(this.targetId, this.selectedCount).subscribe(
      (r) => {
        this.initExplore();
      },
      (e) => console.error(e)
    );
  }
}
