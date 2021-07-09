import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UpgradeDetailsComponent } from './upgrade-details.component';

describe('UpgradeDetailsComponent', () => {
  let component: UpgradeDetailsComponent;
  let fixture: ComponentFixture<UpgradeDetailsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [UpgradeDetailsComponent]
    })
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(UpgradeDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
