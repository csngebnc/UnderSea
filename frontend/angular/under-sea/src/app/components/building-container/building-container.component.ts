import { Component, OnInit, Input } from '@angular/core';
import { Building } from 'src/app/models/building.model';
import { RoundService } from 'src/app/services/round/round.service';
import { imageUrl, images } from 'src/assets/config.json';

@Component({
  selector: 'building-container',
  templateUrl: './building-container.component.html',
  styleUrls: ['./building-container.component.scss'],
})
export class BuildingContainerComponent implements OnInit {
  @Input() buildings: Array<Building>;
  @Input() hasSonar: boolean;

  sonar: string = imageUrl + images.sonar;
  castle: string = imageUrl + images.castle;
  flowcontrol: string = imageUrl + images.flowcontrol;
  stonemine: string = imageUrl + images.stonemine;

  constructor(private roundService: RoundService) {}

  ngOnInit(): void {}

  nextRound(): void {
    this.roundService.nextRound().subscribe(
      (r) => r,
      (e) => console.error(e)
    );
  }
}
