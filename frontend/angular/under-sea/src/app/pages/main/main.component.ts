import { Component, OnInit } from '@angular/core';
import { UserData } from 'src/app/models/userdata.model';
import { Resources } from 'src/app/models/resources.model';
import { BehaviorSubject, forkJoin, Observable } from 'rxjs';
import { ApiService } from 'src/app/services/api/api.service';
import { WebsocketService } from 'src/app/services/websocket/websocket.service';

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
  constructor(
    private apiService: ApiService,
    private wsService: WebsocketService
  ) {
    this.wsService.connect();
    this.wsMessages = this.wsService.messages;
  }

  ngOnInit(): void {
    this.wsMessages.subscribe((r) => {
      console.log(r);
      this.loadResources();
    });
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
