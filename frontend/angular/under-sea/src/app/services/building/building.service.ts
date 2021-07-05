import { Injectable } from '@angular/core';
import {
  BuildingService as bService,
  BuildingDetailsDto,
} from '../generated-code/generated-api-code';
import { Observable } from 'rxjs';
import { BuildingDetails } from 'src/app/models/building-details.model';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root',
})
export class BuildingService {
  constructor(private buildingService: bService) {}

  getBuildings(): Observable<Array<BuildingDetails>> {
    return this.buildingService.userBuildings().pipe(
      map((arr: Array<BuildingDetailsDto>) => {
        console.log(arr);
        const result: Array<BuildingDetails> = [];
        arr.forEach((b) => result.push(b as BuildingDetails));
        console.log(result);
        return result;
      })
    );
  }

  buyBuilding(id: number): Observable<any> {
    return this.buildingService.buy({ buildingId: id });
  }
}
