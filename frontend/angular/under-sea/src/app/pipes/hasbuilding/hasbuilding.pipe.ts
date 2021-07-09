import { Pipe, PipeTransform } from '@angular/core';
import { Building } from 'src/app/models/building.model';

@Pipe({
  name: 'hasbuilding',
})
export class HasbuildingPipe implements PipeTransform {
  transform(buildings: Array<Building>, id: number): boolean {
    const result = buildings.find((b) => b.id === id);

    if (!result || result.buildingsCount === 0) { return false; }
    else { return true; }
  }
}
