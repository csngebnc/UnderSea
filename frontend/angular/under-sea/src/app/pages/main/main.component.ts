import { Component, OnInit } from '@angular/core';
import { UserData } from 'src/app/models/userdata.model';
import { Resources } from 'src/app/models/resources.model';
import { UserService } from 'src/app/services/user/user.service';
import { BehaviorSubject, forkJoin } from 'rxjs';

@Component({
  selector: 'main',
  templateUrl: './main.component.html',
  styleUrls: ['./main.component.scss'],
})
export class MainComponent implements OnInit {
  isLoading = new BehaviorSubject(false);

  resources: Resources | null = null;
  constructor(private userService: UserService) {}

  ngOnInit(): void {
    this.loadResources();
  }

  userData: UserData = {
    name: 'Pepsi Béla',
    round: 12,
    placement: 11,
  };

  loadResources(): void {
    this.isLoading.next(true);

    let details = this.userService.getDetails();

    forkJoin([details]).subscribe(
      (responses) => {
        this.resources = responses[0];
        this.isLoading.next(false);
      },
      (e) => console.log(e)
    );
  }
}
