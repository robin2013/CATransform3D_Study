//
//  ViewController.m
//  CATransform3D_Study
//
//  Created by Robin on 13-7-25.
//  Copyright (c) 2013年 Robin. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)
#define THREE_D_ON YES
#define HEIGHT 568
@interface ViewController ()
{
    CALayer *transform3DLayer,*transform3DLayer0,*transform3DLayer1,*transform3DLayer2;
    CATransform3D transform;
    float x,y,z;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     [self addlayer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (void)runAnimation
{
    transform3DLayer0= [self createLayer];
    transform3DLayer1= [self createLayer];
    transform3DLayer2= [self createLayer];
    [self startLayerAnimation:transform3DLayer0 idx:0];
    [self startLayerAnimation:transform3DLayer1 idx:1];
    [self startLayerAnimation:transform3DLayer2 idx:2];
    
}
- (void)addlayer
{
    transform3DLayer = [CALayer layer];
    transform3DLayer.bounds = CGRectMake(0, 0, 250, 250);
    transform3DLayer.position = CGPointMake(160, 460);
    transform3DLayer.contents = (id)[UIImage imageNamed:@"guide"].CGImage;
    transform3DLayer.anchorPoint = CGPointMake(0.5, 1);
    
    [self.view.layer addSublayer:transform3DLayer];
}
- (CALayer *)createLayer
{
    CALayer *transformLayer = [CALayer layer];
    UIImage *img = [UIImage imageNamed:@"guide"];
    transformLayer.contents = (id)img.CGImage;
    [transformLayer setFrame:CGRectMake(0, 0, 320, HEIGHT/2)];
    [self.view.layer addSublayer:transformLayer];
    return transformLayer;
}

- (void)setAnimationDoirect
{
    x=y=z=0;
    switch (_semDirectin.selectedSegmentIndex) {
        case 0:
            x=1;
            break;
        case 1:
            y=1;
            break;
        default:
            z=1;
            break;
    }
}
- (IBAction)btnRunClick:(id)sender {
     [transform3DLayer removeFromSuperlayer];
    [self runAnimation];
    
}
- (void)dealloc {
    [_semDirectin release];
    [_semMold release];
    [super dealloc];
}

- (IBAction)animaitonDirectionChanged:(id)sender {
    transform3DLayer.transform = CATransform3DIdentity;//重置
}

- (IBAction)animationTypeChanged:(UISegmentedControl *)sender {
    [self setAnimationDoirect];
    CATransform3D pre = CATransform3DIdentity;
    pre.m34 = 1.0 / -400.0;//旋转式需要修改买4, 不然是看不到效果的
    switch (sender.selectedSegmentIndex) {
        case 0:
            transform = CATransform3DTranslate(pre, x*50, y*50, z*50) ;//平移
            break;
        case 1:
            transform = CATransform3DScale(pre, x*1.5+1, y*1.5+1, z*1.5+1) ;//缩放
            break;
        default:
            transform = CATransform3DRotate(pre, DEGREES_TO_RADIANS(45), x, y, z) ;//旋转
            break;
    }
    transform3DLayer.transform = transform;
    
    
}

- (IBAction)btnStopCLick:(id)sender {
    
    [transform3DLayer0 removeAllAnimations];
    [transform3DLayer0 removeFromSuperlayer];
    [transform3DLayer1 removeAllAnimations];
    [transform3DLayer1 removeFromSuperlayer];
    [transform3DLayer2 removeAllAnimations];
    [transform3DLayer2 removeFromSuperlayer];
    [self addlayer];
    

}
- (void)startLayerAnimation:(CALayer *)iv idx:(NSInteger)idx{
    [CATransaction flush];//提交并等待之前的动画全部执行完成.
    CATransform3D t = CATransform3DIdentity;
    if (THREE_D_ON) {
        t.m34 = 1.0 / -400.0;
        t = CATransform3DRotate(t, DEGREES_TO_RADIANS(45),1.0,0.0,0.0);
        
    }
    t = CATransform3DTranslate(t, 0, (1 - idx) * HEIGHT / 2.0, 0);
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    iv.transform = t;//把图片移动到顶端时不需要动画
    [CATransaction setDisableActions:NO];
    [CATransaction commit];
    CGFloat m = idx + 1;
    CGFloat ty = m * HEIGHT * 0.5;
    NSTimeInterval duration = m * 3;
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:duration];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear]];
    [CATransaction setCompletionBlock:^{
        [self startLayerAnimation:iv idx:2];
    }];
    iv.transform = CATransform3DTranslate(iv.transform, 0, ty, 0);
    [CATransaction commit];
    
    
}

@end
