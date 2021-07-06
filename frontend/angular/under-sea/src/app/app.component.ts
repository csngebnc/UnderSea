import { Component } from '@angular/core';
import { Select } from '@ngxs/store';
import { LoadingState } from './states/loading/loading.state';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent {
  @Select(LoadingState)
  loading$: Observable<boolean>;

  constructor() {}
  title = 'under-sea';
}
