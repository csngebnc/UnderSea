import { Component, OnInit } from '@angular/core';
import { UserData } from 'src/app/models/userdata.model';
import { Resources } from 'src/app/models/resources.model';
import { UserService } from 'src/app/services/user/user.service';
import { BehaviorSubject, forkJoin } from 'rxjs';
import { ApiService } from 'src/app/services/api/api.service';

@Component({
  selector: 'main',
  templateUrl: './main.component.html',
  styleUrls: ['./main.component.scss'],
})
export class MainComponent implements OnInit {
  isLoading = new BehaviorSubject(false);

  resources: Resources | null = null;

  userData: UserData | null = null;
  constructor(
    private userService: UserService,
    private apiService: ApiService
  ) {}

  ngOnInit(): void {
    this.loadResources();
  }

  loadResources(): void {
    this.isLoading.next(true);

    let details = this.userService.getDetails();
    let user = this.apiService.getUser();

    forkJoin([details, user]).subscribe(
      (responses) => {
        this.resources = responses[0];
        this.userData = responses[1];
        this.isLoading.next(false);
      },
      (e) => console.log(e)
    );
  }
}
