import { Component, OnInit, Input } from '@angular/core';
import { AuthenticationService } from 'src/app/services/authentication/authentication.service';
import { imageUrl, images } from 'src/assets/config.json';

@Component({
  selector: 'profilecard',
  templateUrl: './profilecard.component.html',
  styleUrls: ['./profilecard.component.scss'],
})
export class ProfilecardComponent implements OnInit {
  @Input() name: string;

  img: string = imageUrl + images.profile;
  constructor(private authService: AuthenticationService) { }

  ngOnInit(): void { }

  onLogout(): void {
    this.authService.logout();
  }
}
