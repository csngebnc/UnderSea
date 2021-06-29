import { Component, OnInit } from '@angular/core';
import { UserData } from 'src/app/models/userdata.model';
import { Resources } from 'src/app/models/resources.model';
import { UserService } from 'src/app/services/user/user.service';
import { BehaviorSubject } from 'rxjs';

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
    this.userService.getDetails().subscribe((r) => {
      this.resources = r;
      this.isLoading.next(false);
    });
  }

  userData: UserData = {
    name: 'Pepsi Béla',
    round: 12,
    placement: 11,
  };
}
