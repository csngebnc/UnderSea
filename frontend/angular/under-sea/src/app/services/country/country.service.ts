import { Injectable } from '@angular/core';
import { CountryService as cService } from '../generated-code/generated-api-code';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class CountryService {
  constructor(private countryService: cService) {}

  getCountryName(): Observable<string> {
    return this.countryService.nameGet();
  }

  setCountryName(name: string): Observable<any> {
    return this.countryService.namePut(name);
  }
}
