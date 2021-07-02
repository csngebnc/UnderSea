import { Component, OnInit } from '@angular/core';
import { AttackerUnit } from 'src/app/models/attacker-unit.model';
import { PagedList } from 'src/app/models/paged-list.model';
import { BattleService } from 'src/app/services/battle/battle.service';
import { BehaviorSubject, forkJoin, Observable } from 'rxjs';
import { AttackUnitDto } from 'src/app/services/generated-code/generated-api-code';
import { Select, Store } from '@ngxs/store';
import { ResourcesState } from 'src/app/states/resources/resources.state';
import { Unit } from 'src/app/models/unit.model';
import { GetResources } from 'src/app/states/resources/resources.actions';

@Component({
  selector: 'attack',
  templateUrl: './attack.component.html',
  styleUrls: ['./attack.component.scss'],
})
export class AttackComponent implements OnInit {
  @Select(ResourcesState.units)
  private unitState$: Observable<Array<Unit>>;

  units: Array<AttackerUnit> = [];

  players: PagedList = {
    list: [],
    pageNumber: 1,
    pageSize: 0,
    allResultsCount: 0,
  };

  isLoading$ = new BehaviorSubject(false);
  filter: string | undefined = undefined;
  targetId: number;
  attackerUnits: Array<AttackUnitDto> = [];

  constructor(private battleService: BattleService, private store: Store) {
    this.unitState$.subscribe((arr: Array<Unit>) => {
      this.units = [];
      arr.forEach((u) => {
        if (u.id != 4) {
          //az if átmeneti megoldás, amíg megoldják a backenden hogy ne crasheljen a felfedezeőre
          this.units.push({
            id: u.id,
            name: u.name,
            count: u.count,
            imageUrl: u.icon,
          });
        }
      });
      this.attackerUnits = [];
      this.units.forEach((unit) => {
        this.attackerUnits.push({ unitId: unit.id, count: 0 });
      });
    });
  }

  ngOnInit(): void {
    this.initPlayers();
  }

  private initPlayers(): void {
    this.isLoading$.next(true);

    this.battleService.getUsers(this.players.pageNumber, this.filter).subscribe(
      (r) => {
        this.players = r;

        this.isLoading$.next(false);
      },
      (e) => console.error(e)
    );
  }

  onSelectTarget(id: number): void {
    this.targetId = id;
  }

  onSetUnit(unit: AttackUnitDto): void {
    let index = this.attackerUnits.findIndex((u) => u.unitId === unit.unitId);
    this.attackerUnits[index].count = unit.count;
  }

  isButtonDisabled(): boolean {
    let sum: number = 0;
    this.attackerUnits.forEach((unit) => {
      sum += unit.count;
    });

    return !(this.targetId && sum);
  }

  onSwitchPage(pageNumber: number): void {
    this.players.pageNumber = pageNumber;
  }

  onFilter(filter: string) {
    this.filter = filter;
    this.players.pageNumber = 1;
    this.initPlayers();
  }

  attack(): void {
    this.battleService.attack(this.targetId, this.attackerUnits).subscribe(
      (r) => {
        this.store.dispatch(GetResources);
        this.initPlayers();
      },
      (e) => console.error(e)
    );
  }
}
