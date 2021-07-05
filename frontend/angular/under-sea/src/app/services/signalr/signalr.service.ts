import { Injectable } from '@angular/core';
import * as signalR from '@microsoft/signalr'; // or from "@microsoft/signalr" if you are using a new library
import { apiUrl } from 'src/assets/config.json';

@Injectable({
  providedIn: 'root',
})
export class SignalRService {
  hubConnection: any = signalR.HubConnection;

  public startConnection = () => {
    this.hubConnection = new signalR.HubConnectionBuilder()
      .withUrl(`${apiUrl}/roundHub`)
      .build();
    this.hubConnection
      .start()
      .then(() => console.log('Connection started'))
      .catch((err: any) =>
        console.log('Error while starting connection: ' + err)
      );
  };
}
