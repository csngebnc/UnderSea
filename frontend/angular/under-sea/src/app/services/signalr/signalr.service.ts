import { Injectable } from '@angular/core';
import { HubConnectionBuilder, HubConnection } from '@microsoft/signalr';
import { apiUrl } from 'src/assets/config.json';

@Injectable({
  providedIn: 'root',
})
export class SignalRService {
  hubConnection: any = HubConnection;

  public startConnection = () => {
    this.hubConnection = new HubConnectionBuilder()
      .withUrl(`${apiUrl}/roundHub`)
      .build();
    this.connectInit();
    this.reconnectInit();
  };

  private reconnectInit(): void {
    this.hubConnection.onclose(() => {
      setTimeout(() => {
        this.connectInit();
      }, 3000);
    });
  }

  private connectInit(): void {
    this.hubConnection
      .start()
      .then(() => console.log('Connection started'))
      .catch((err: any) =>
        console.log('Error while starting connection: ' + err)
      );
  }
}
