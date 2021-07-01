import { Component, OnInit } from '@angular/core';
import { AttackerUnit } from 'src/app/models/attacker-unit.model';
import { AttackerUnitDto } from 'src/app/models/dto/attacker-unit-dto.model';
import { PagedList } from 'src/app/models/paged-list.model';
import { BattleService } from 'src/app/services/battle/battle.service';
import { BehaviorSubject, forkJoin } from 'rxjs';

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

  isLoading = new BehaviorSubject(false);
  filter: string | undefined = undefined;
  targetId: number;
  attackerUnits: Array<AttackerUnitDto> = [];

  constructor(private battleService: BattleService) {}

  ngOnInit(): void {
    this.initAttack();
  }

  private initAttack(): void {
    this.isLoading.next(true);

    let units = this.battleService.getAttackerUnits();
    let players = this.battleService.getUsers(
      this.players.pageNumber,
      this.filter
    );

    forkJoin([units, players]).subscribe(
      (responses) => {
        this.units = responses[0];
        this.players = responses[1];

        this.units.forEach((unit) => {
          this.attackerUnits.push({ unitId: unit.id, count: 0 });
        });

        this.isLoading.next(false);
      },
      (e) => console.log(e)
    );
  }
  private initPlayers(): void {
    this.isLoading.next(true);

    this.battleService.getUsers(this.players.pageNumber, this.filter).subscribe(
      (r) => {
        this.players = r;

        this.isLoading.next(false);
      },
      (e) => console.log(e)
    );
  }

  onSelectTarget(id: number): void {
    this.targetId = id;
  }

  onSetUnit(unit: AttackerUnitDto): void {
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
    console.log(filter);
  }

  attack(): void {
    this.battleService.attack(this.targetId, this.attackerUnits).subscribe(
      (r) => {
        console.log(r);
        this.initAttack();
      },
      (e) => console.log(e)
    );
  }
}
