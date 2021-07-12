import { Component, OnInit, Input } from '@angular/core';
import { Upgrade } from 'src/app/models/upgrade.model';

@Component({
  selector: 'upgrade-details',
  templateUrl: './upgrade-details.component.html',
  styleUrls: ['./upgrade-details.component.scss']
})
export class UpgradeDetailsComponent implements OnInit {

  @Input() upgrade: Upgrade;

  constructor() { }

  ngOnInit(): void {
  }

}
