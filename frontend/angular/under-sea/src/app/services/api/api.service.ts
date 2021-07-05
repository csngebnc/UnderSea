import { Injectable } from '@angular/core';
import {
  ApiService as aService,
  UserInfoDto,
  CountryDetailsDto,
} from '../generated-code/generated-api-code';
import { UserData } from 'src/app/models/userdata.model';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { Resources } from 'src/app/models/resources.model';
import { Unit } from 'src/app/models/unit.model';
import { Building } from 'src/app/models/building.model';

@Injectable({
  providedIn: 'root',
})
export class ApiService {
  constructor(private apiService: aService) {}

  getUser(): Observable<UserData> {
    return this.apiService.user().pipe(
      map((u: UserInfoDto) => {
        return {
          name: u.name,
          placement: u.placement,
          round: u.round,
        };
      })
    );
  }

  getDetails(): Observable<Resources> {
    return this.apiService.country().pipe(
      map((cd: CountryDetailsDto) => {
        const units: Array<Unit> = cd.units.map((u) => {
          return { id: u.id, name: u.name, count: u.count, icon: u.imageUrl };
        });

        const buildings: Array<Building> = cd.buildings.map((b) => {
          return {
            id: b.id,
            name: b.name,
            buildingsCount: b.buildingsCount,
            activeConstructionCount: b.activeConstructionCount,
            iconImageUrl: b.iconImageUrl,
          };
        });

        return {
          units: units,
          buildings: buildings,
          corals: cd.coral,
          coralsPerRound: cd.currentCoralProduction,
          pearls: cd.pearl,
          pearlsPerRound: cd.currentPearlProduction,
          hasSonar: cd.hasSonarCanon,
          maxUnitCount: cd.maxUnitCount,
        };
      })
    );
  }
}
