//
//  TestViewController.m
//  Bacteria
//
//  Created by Igor on 13/01/2017.
//  Copyright (c) 2017 Igor Kislyuk. All rights reserved.
//

#define DEGREES_TO_RADIANS(degrees) ((M_PI * degrees)/180.f)

#import "TestViewController.h"

@interface TestViewController ()
@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet UISlider *angleSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *axisControl;


@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    CATransform3D transform3D = CATransform3DIdentity;
    
    transform3D.m34 = 1.0 / -500.0;
    
    transform3D = CATransform3DRotate(transform3D, -DEGREES_TO_RADIANS(30), 0, 1, 0);
    
    
    
    self.testView.layer.transform = transform3D;
    


}
- (IBAction)actionApply:(id)sender {
    
    CATransform3D transform3D = CATransform3DIdentity;
    
    transform3D.m34 = 1.0 / -500.0;
    
    CGFloat x, y, z = 0;
    
    switch (self.axisControl.selectedSegmentIndex) {
        case 0:
            x = 1;
            break;
        case 1:
            y = 1;
            break;
        case 2:
            z = 1;
            break;
    }
    CGFloat result = DEGREES_TO_RADIANS([self angleFromSlider:self.angleSlider]);
    
    NSLog(@"%f with original angle %f", result, [self angleFromSlider:self.angleSlider]);
    
    transform3D = CATransform3DRotate(transform3D, result, x, y, z);
    
    
    self.testView.layer.transform = transform3D;
    
}

- (CGFloat)angleFromSlider:(UISlider *)slider {
    
    CGFloat result;
    
    if (slider.value < 0.5f) {
        //minus value
        result = - ( slider.value / 0.5f ) * 90.f;
        
    } else if (slider.value == 0.5f) {
        //zero
        result = 0.0f;
    } else {
        //plus value
        result = ( (slider.value - 0.5) / 0.5f ) * 90.f;
    }
    
    
    return result;
    
}

@end
