import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PagerButtonsComponent } from './pager-buttons.component';

describe('PagerButtonsComponent', () => {
  let component: PagerButtonsComponent;
  let fixture: ComponentFixture<PagerButtonsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PagerButtonsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PagerButtonsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
