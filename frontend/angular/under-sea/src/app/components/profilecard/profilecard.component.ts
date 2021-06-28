import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'profilecard',
  templateUrl: './profilecard.component.html',
  styleUrls: ['./profilecard.component.scss']
})
export class ProfilecardComponent implements OnInit {

  @Input() name: string;

  constructor() { }

  ngOnInit(): void {
  }

}
