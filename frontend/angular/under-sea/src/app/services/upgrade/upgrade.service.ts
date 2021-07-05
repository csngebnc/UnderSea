import { Injectable } from '@angular/core';
import {
  UpgradeService as uService,
  UpgradeDto,
} from '../generated-code/generated-api-code';
import { Upgrade } from 'src/app/models/upgrade.model';
import { Observable } from 'rxjs/internal/Observable';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root',
})
export class UpgradeService {
  constructor(private upgradeService: uService) {}

  getUpgrades(): Observable<Array<Upgrade>> {
    return this.upgradeService.list().pipe(
      map((arr: Array<UpgradeDto>) => {
        const result: Array<Upgrade> = [];

        arr.forEach((u: UpgradeDto) => {
          result.push(u as Upgrade);
        });

        return result;
      })
    );
  }

  buyUpgrade(id: number): Observable<any> {
    return this.upgradeService.buy({ upgradeId: id });
  }
}
