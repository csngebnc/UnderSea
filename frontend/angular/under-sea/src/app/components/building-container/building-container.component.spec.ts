import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BuildingContainerComponent } from './building-container.component';

describe('BuildingContainerComponent', () => {
  let component: BuildingContainerComponent;
  let fixture: ComponentFixture<BuildingContainerComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ BuildingContainerComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(BuildingContainerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
