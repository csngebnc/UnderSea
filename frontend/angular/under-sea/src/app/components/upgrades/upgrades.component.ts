import { Component, OnInit } from '@angular/core';
import { Upgrade } from 'src/app/models/upgrade.model';
import { BehaviorSubject } from 'rxjs';
import { UpgradeService } from 'src/app/services/upgrade/upgrade.service';

@Component({
  selector: 'upgrades',
  templateUrl: './upgrades.component.html',
  styleUrls: ['./upgrades.component.scss'],
})
export class UpgradesComponent implements OnInit {
  selectedUpgrade: number | null = null;
  isResearching: boolean = false;

  isLoading = new BehaviorSubject(false);

  upgrades: Array<Upgrade> = [];

  constructor(private upgradeService: UpgradeService) {}

  ngOnInit(): void {
    this.initUpgrades();
  }

  private initUpgrades(): void {
    this.isLoading.next(true);

    this.upgradeService.getUpgrades().subscribe(
      (r: Array<Upgrade>) => {
        console.log(r);
        this.upgrades = r;
        this.isLoading.next(false);
      },
      (e) => console.log(e)
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
          console.log(r);
          this.isResearching = true;
          this.initUpgrades();
        },
        (e) => console.log(e)
      );
    }
  }
}
