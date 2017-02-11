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
@property (weak, nonatomic) IBOutlet UIView *testView2;

@property (weak, nonatomic) IBOutlet UISlider *eyeVisionPositionSlider;

@property (weak, nonatomic) IBOutlet UISlider *negativeSlider;
@property (weak, nonatomic) IBOutlet UISlider *positiveSlider;

@property (weak, nonatomic) IBOutlet UISegmentedControl *axisControl;


@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setEyeVisionPositionWith:500.f];
}

- (void)setEyeVisionPositionWith:(float)value {
    
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D.m34 = 1.0 / -value;
    transform3D = CATransform3DRotate(transform3D, -DEGREES_TO_RADIANS(30), 0, 1, 0);
    
    self.containerView.layer.sublayerTransform = transform3D;
}

-(IBAction)actionChangeEyeVision:(id)sender {
    if ([sender isKindOfClass:[UISlider class]]) {
        UISlider *slider = (UISlider *)sender;
        
        [self setEyeVisionPositionWith:slider.value];
    }
}

- (IBAction)actionApply:(id)sender {
    
    if (![sender isKindOfClass:[UISlider class]]) {
        return;
    }
    
    UISlider *slider = (UISlider *)sender;
    
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
    
    CGFloat result = DEGREES_TO_RADIANS(slider.value);
    
    NSLog(@"%f with original angle %f", result, slider.value);
    
    CATransform3D transform3D = CATransform3DMakeRotation(result, x, y, z);
    
    
    self.testView.layer.transform = transform3D;
}

- (IBAction)actionAnimate:(id)sender {
    
    //prepare
    
    
    
    [UIView animateKeyframesWithDuration:3.0f delay:0 options:UIViewKeyframeAnimationOptionAutoreverse | UIViewKeyframeAnimationOptionRepeat animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.0f animations:^{
            self.testView2.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(120.0f), 0, 1, 0);
            self.testView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(30.0f), 0, 1, 0);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.5f animations:^{
            self.testView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(-60.0f), 0, 1, 0);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5f relativeDuration:0.5f animations:^{
            self.testView2.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(30.0f), 0, 1, 0);
        }];
    
        
    } completion:^(BOOL finished) {
        
    }];
}

@end
