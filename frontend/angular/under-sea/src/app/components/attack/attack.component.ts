import { Component, OnInit } from '@angular/core';
import { AttackerUnit } from 'src/app/models/attacker-unit.model';
import { PagedList } from 'src/app/models/paged-list.model';
import { BattleService } from 'src/app/services/battle/battle.service';
import { forkJoin } from 'rxjs';
import { AttackUnitDto } from 'src/app/services/generated-code/generated-api-code';

@Component({
  selector: 'attack',
  templateUrl: './attack.component.html',
  styleUrls: ['./attack.component.scss'],
})
export class AttackComponent implements OnInit {
  units: Array<AttackerUnit> = [];

  players: PagedList = {
    list: [],
    pageNumber: 1,
    pageSize: 0,
    allResultsCount: 0,
  };

  filter: string | undefined = undefined;
  targetId: number;
  attackerUnits: Array<AttackUnitDto> = [];

  constructor(private battleService: BattleService) {}

  ngOnInit(): void {
    this.initAttack();
  }

  private initPlayers(): void {
    this.battleService.getUsers(this.players.pageNumber, this.filter).subscribe(
      (r) => {
        this.players = r;
      },
      (e) => console.error(e)
    );
  }

  private initAttack(): void {
    this.players.pageNumber = 1;

    let users = this.battleService.getUsers(this.players.pageNumber, undefined);
    let units = this.battleService.getAttackerUnits();

    forkJoin([users, units]).subscribe(
      (responses) => {
        this.players = responses[0];
        this.units = responses[1];
      },
      (e) => console.error(e)
    );
  }

  onSelectTarget(id: number): void {
    this.targetId = id;
  }

  onSetUnit(unit: AttackUnitDto): void {
    const index = this.attackerUnits.findIndex((u) => u.unitId === unit.unitId);
    if (index !== -1) {
      this.attackerUnits[index].count = unit.count;
    } else {
      this.attackerUnits.push({ unitId: unit.unitId, count: unit.count });
    }
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
    this.initPlayers();
  }

  onFilter(filter: string): void {
    this.filter = filter;
    this.players.pageNumber = 1;
    this.initPlayers();
  }

  attack(): void {
    this.battleService.attack(this.targetId, this.attackerUnits).subscribe(
      (r) => {
        this.initAttack();
      },
      (e) => console.error(e)
    );
  }
}
