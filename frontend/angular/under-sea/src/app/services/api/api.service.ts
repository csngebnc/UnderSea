import { Injectable } from '@angular/core';
import {
  ApiService as aService,
  UserInfoDto,
} from '../generated-code/generated-api-code';
import { UserData } from 'src/app/models/userdata.model';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

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
}
