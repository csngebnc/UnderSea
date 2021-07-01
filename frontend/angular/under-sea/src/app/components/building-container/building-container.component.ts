import { Component, OnInit, Input } from '@angular/core';
import { Building } from 'src/app/models/building.model';
import { RoundService } from 'src/app/services/round/round.service';
import { webSocket } from 'rxjs/webSocket';
import { WebsocketService } from 'src/app/services/websocket/websocket.service';

@Component({
  selector: 'building-container',
  templateUrl: './building-container.component.html',
  styleUrls: ['./building-container.component.scss'],
})
export class BuildingContainerComponent implements OnInit {
  @Input() buildings: Array<Building>;
  @Input() hasSonar: boolean;

  constructor(
    private roundService: RoundService,
    private wsService: WebsocketService
  ) {}

  ngOnInit(): void {}

  playerHasBuilding(id: number): boolean {
    let result = this.buildings.find((c) => c.id === id);

    if (!result || result.buildingsCount === 0) return false;
    else return true;
  }

  nextRound(): void {
    this.roundService.nextRound().subscribe();
  }
}
