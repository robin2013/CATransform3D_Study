//
//  ViewController.h
//  CATransform3D_Study
//
//  Created by Robin on 13-7-25.
//  Copyright (c) 2013年 Robin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)btnRunClick:(id)sender;
@property (retain, nonatomic) IBOutlet UISegmentedControl *semDirectin;
@property (retain, nonatomic) IBOutlet UISegmentedControl *semMold;
- (IBAction)animaitonDirectionChanged:(id)sender;
- (IBAction)animationTypeChanged:(UISegmentedControl *)sender;

- (IBAction)btnStopCLick:(id)sender;

@end
