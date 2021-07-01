import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UnitSliderComponent } from './unit-slider.component';

describe('UnitSliderComponent', () => {
  let component: UnitSliderComponent;
  let fixture: ComponentFixture<UnitSliderComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ UnitSliderComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(UnitSliderComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
