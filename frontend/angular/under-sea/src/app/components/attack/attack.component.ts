import { GetResources } from 'src/app/states/resources/resources.actions';
import { Component, OnInit } from '@angular/core';
import { AttackerUnit } from 'src/app/models/attacker-unit.model';
import { PagedList } from 'src/app/models/paged-list.model';
import { BattleService } from 'src/app/services/battle/battle.service';
import { forkJoin, Observable } from 'rxjs';
import { AttackUnitDto } from 'src/app/services/generated-code/generated-api-code';
import { Select, Store } from '@ngxs/store';
import { LoadingState } from 'src/app/states/loading/loading.state';
import { ToastrService } from 'ngx-toastr';

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
  generalSelected: boolean = false;
  selectedUnitcount = 0;

  @Select(LoadingState.isLoading)
  loading$: Observable<boolean>;

  constructor(
    private battleService: BattleService,
    private store: Store,
    private toastr: ToastrService
  ) {}

  ngOnInit(): void {
    this.initAttack();
  }

  private initPlayers(): void {
    this.battleService.getUsers(this.players.pageNumber, this.filter).subscribe(
      (r) => {
        this.players = r;
      },
      (e) => {
        const error = JSON.parse(e['response']);
        const errorText = Object.values(error['errors'])[0][0];
        this.toastr.error(errorText);
      }
    );
  }

  private initAttack(): void {
    this.players.pageNumber = 1;

    let users = this.battleService.getUsers(this.players.pageNumber, undefined);
    let units = this.battleService.getAttackerUnits();

    forkJoin([users, units]).subscribe(
      ([users, units]) => {
        this.players = users;
        this.units = units;
      },
      (e) => {
        const error = JSON.parse(e['response']);
        const errorText = Object.values(error['errors'])[0][0];
        this.toastr.error(errorText);
      }
    );
  }

  onSelectTarget(id: number): void {
    this.targetId = id;
  }

  onSetUnit(unit: AttackUnitDto): void {
    if (unit.unitId === 5) this.setGeneral(unit);
    this.setUnits(unit);
    this.sumUnits();
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
        this.store.dispatch(GetResources);
        this.initAttack();
      },
      (e) => {
        const error = JSON.parse(e['response']);
        const errorText = Object.values(error['errors'])[0][0];
        this.toastr.error(errorText);
      }
    );
  }

  private sumUnits(): void {
    let sum: number = 0;
    this.attackerUnits.forEach((unit) => {
      sum += unit.count;
    });

    this.selectedUnitcount = sum;
  }

  private setGeneral(general: AttackUnitDto): void {
    if (general.count === 0) this.generalSelected = false;
    else this.generalSelected = true;
  }

  private setUnits(unit: AttackUnitDto): void {
    const index = this.attackerUnits.findIndex((u) => u.unitId === unit.unitId);
    if (index !== -1) {
      this.attackerUnits[index].count = unit.count;
    } else {
      if (unit.count !== 0) {
        this.attackerUnits.push({ unitId: unit.unitId, count: unit.count });
      } else {
        this.attackerUnits.splice(index, 1);
      }
    }
  }
}
