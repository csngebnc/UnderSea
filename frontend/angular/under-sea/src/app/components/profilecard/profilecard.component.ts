import { Component, OnInit, Input } from '@angular/core';
import { AuthenticationService } from 'src/app/services/authentication/authentication.service';

@Component({
  selector: 'profilecard',
  templateUrl: './profilecard.component.html',
  styleUrls: ['./profilecard.component.scss'],
})
export class ProfilecardComponent implements OnInit {
  @Input() name: string;

  constructor(private authService: AuthenticationService) {}

  ngOnInit(): void {}

  onLogout(): void {
    this.authService.logout();
  }
}
