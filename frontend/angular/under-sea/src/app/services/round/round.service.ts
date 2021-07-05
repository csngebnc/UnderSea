import { Injectable } from '@angular/core';
import { RoundService as rService } from '../generated-code/generated-api-code';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class RoundService {
  constructor(private roundService: rService) {}

  nextRound(): Observable<void> {
    return this.roundService.callNextRound();
  }
}
