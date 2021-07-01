import { Injectable } from '@angular/core';
import { webSocket, WebSocketSubject } from 'rxjs/webSocket';
import { wsUrl } from 'src/assets/config.json';

@Injectable({
  providedIn: 'root',
})
export class WebsocketService {
  private socket: WebSocketSubject<any>;
  public messages;

  constructor() {}

  connect(): void {
    this.socket = this.getNewWebSocket();
    this.messages = this.socket.asObservable();
    console.log(this.socket);
  }

  private getNewWebSocket() {
    const ws = webSocket(wsUrl);
    console.log(ws);
    return ws;
  }
  sendMessage(msg: any) {
    if (this.socket) this.socket.next(msg);
  }
  close() {
    if (this.socket) this.socket.complete();
  }
}
