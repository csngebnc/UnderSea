import { Material } from './../../models/material.model';
import { Injectable } from '@angular/core';
import {
  BuildingService as bService,
  BuildingDetailsDto,
} from '../generated-code/generated-api-code';
import { Observable } from 'rxjs';
import { BuildingDetails } from 'src/app/models/building-details.model';
import { map } from 'rxjs/operators';
import { Effect } from 'src/app/models/effect.model';

@Injectable({
  providedIn: 'root',
})
export class BuildingService {
  constructor(private buildingService: bService) {}

  getBuildings(): Observable<Array<BuildingDetails>> {
    return this.buildingService.userBuildings().pipe(
      map((arr: Array<BuildingDetailsDto>) => {
        const result: Array<BuildingDetails> = [];
        arr.forEach((b) => {
          const materials: Array<Material> = b.requiredMaterials.map((m) => {
            return {
              id: m.id,
              name: m.name,
              count: m.amount,
            };
          });

          const effects: Array<Effect> = b.effects.map((e) => {
            return e as Effect;
          });

          result.push({
            id: b.id,
            imageUrl: b.imageUrl,
            name: b.name,
            price: materials,
            underConstruction: b.underConstruction,
            effects: effects,
            count: b.count,
          });
        });
        return result;
      })
    );
  }

  buyBuilding(id: number): Observable<any> {
    return this.buildingService.buy({ buildingId: id });
  }
}
