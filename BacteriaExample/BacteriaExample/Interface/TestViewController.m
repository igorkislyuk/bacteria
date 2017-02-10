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
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UISlider *angleSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *axisControl;
@property (weak, nonatomic) IBOutlet UISlider *eyeVisionPositionSlider;


@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setEyeVisionPositionWith:500.f];
    
    self.testView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(0), 0, 1, 0);
    
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform"];
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    basic.duration = 4.f;
    
    basic.fromValue = [NSValue valueWithCATransform3D:self.testView.layer.transform];
    basic.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(M_PI), 0, 1, 0)];
    
    [self.testView.layer addAnimation:basic forKey:nil];
}

- (void)setEyeVisionPositionWith:(float)value {
    
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D.m34 = 1.0 / -value;
    transform3D = CATransform3DRotate(transform3D, -DEGREES_TO_RADIANS(30), 0, 1, 0);
    
    self.containerView.layer.sublayerTransform = transform3D;
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
    transform3D = CATransform3DTranslate(transform3D, 0, 0, 0);
    
    self.testView.layer.transform = transform3D;
    
    [self setEyeVisionPositionWith:self.eyeVisionPositionSlider.value];
    
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
