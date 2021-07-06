import { Component, OnInit, Input } from '@angular/core';
import { BuildingDetails } from 'src/app/models/building-details.model';

@Component({
  selector: 'building-details',
  templateUrl: './building-details.component.html',
  styleUrls: ['./building-details.component.scss'],
})
export class BuildingDetailsComponent implements OnInit {
  @Input() building: BuildingDetails;

  constructor() {}

  ngOnInit(): void {}
}
