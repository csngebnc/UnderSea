import { Component, OnInit } from '@angular/core';
import { UserData } from 'src/app/models/userdata.model';
import { Resources } from 'src/app/models/resources.model';
import { BehaviorSubject, forkJoin, Observable } from 'rxjs';
import { ApiService } from 'src/app/services/api/api.service';
import { SignalRService } from 'src/app/services/signalr/signalr.service';

@Component({
  selector: 'main',
  templateUrl: './main.component.html',
  styleUrls: ['./main.component.scss'],
})
export class MainComponent implements OnInit {
  isLoading = new BehaviorSubject(false);
  wsMessages: Observable<any> = null;

  resources: Resources | null = null;

  userData: UserData | null = null;
  constructor(private apiService: ApiService, private signalr: SignalRService) {
    this.signalr.startConnection();
    this.signalr.hubConnection.on('SendMessage', (round: number) => {
      console.log(round);
      this.loadResources();
    });
  }

  ngOnInit(): void {
    this.loadResources();
  }

  private loadResources(): void {
    this.isLoading.next(true);

    let details = this.apiService.getDetails();
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

  onBuy(): void {
    this.loadDetails();
  }

  private loadDetails(): void {
    this.apiService.getDetails().subscribe(
      (r) => {
        this.resources = r;
      },
      (e) => console.log(e)
    );
  }
}
