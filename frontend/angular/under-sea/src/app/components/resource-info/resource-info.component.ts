import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'resource-info',
  templateUrl: './resource-info.component.html',
  styleUrls: ['./resource-info.component.scss'],
})
export class ResourceInfoComponent implements OnInit {
  @Input() img: string;
  @Input() count: number;
  @Input() perRound?: number;
  @Input() underConstruction?: number;

  constructor() {}

  ngOnInit(): void {}
}
