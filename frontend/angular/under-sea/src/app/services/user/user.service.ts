import { Injectable } from '@angular/core';
import { UserService as uService } from '../generated-code/generated-api-code';
import { map } from 'rxjs/operators';
import { Resources } from '../../models/resources.model';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  constructor(private userService: uService) {}

  getDetails(): Observable<Resources> {
    return this.userService.details().pipe(
      map((u) => {
        const r: Resources = {
          units: u.units,
          buildings: u.buildings,
          corals: u.currentCoral,
          coralsPerRound: u.currentCoralProduction,
          pearls: u.currentPearl,
          pearlsPerRound: u.currentPearlProduction,
        };
        return r;
      })
    );
  }
}
