import { Component, OnInit } from '@angular/core';
import { Upgrade } from 'src/app/models/upgrade.model';
import { UpgradeService } from 'src/app/services/upgrade/upgrade.service';
import { Select } from '@ngxs/store';
import { LoadingState } from 'src/app/states/loading/loading.state';
import { Observable } from 'rxjs';

@Component({
  selector: 'upgrades',
  templateUrl: './upgrades.component.html',
  styleUrls: ['./upgrades.component.scss'],
})
export class UpgradesComponent implements OnInit {
  selectedUpgrade: number | null = null;
  isResearching: boolean = false;

  upgrades: Array<Upgrade> = [];

  @Select(LoadingState.isLoading)
  loading$: Observable<boolean>;

  constructor(private upgradeService: UpgradeService) {}

  ngOnInit(): void {
    this.initUpgrades();
  }

  private initUpgrades(): void {
    this.upgradeService.getUpgrades().subscribe(
      (r: Array<Upgrade>) => {
        this.upgrades = r;
      },
      (e) => console.error(e)
    );

    this.upgrades.forEach((u) => {
      if (u.isUnderConstruction) this.isResearching = true;
    });
  }

  setUpgrade(id: number): void {
    this.selectedUpgrade = id;
  }

  onBuy(): void {
    if (this.selectedUpgrade !== null) {
      this.upgradeService.buyUpgrade(this.selectedUpgrade).subscribe(
        (r) => {
          this.isResearching = true;
          this.initUpgrades();
        },
        (e) => console.error(e)
      );
    }
  }
}
