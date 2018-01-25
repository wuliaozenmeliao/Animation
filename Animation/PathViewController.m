//
//  PathViewController.m
//  Animation
//
//  Created by XinGou on 2018/1/24.
//  Copyright © 2018年 XinGou. All rights reserved.
//

#import "PathViewController.h"

@interface PathViewController ()
{
    UIButton *btn;
    NSMutableArray *btnArr;
}
@end

@implementation PathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    btnArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<5; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"chooser-moment-icon-camera"] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 15;
        [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        __weak typeof(self) weakSelf = self;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf.view);
            make.height.width.offset(30);
        }];
        [btnArr addObject:btn];
    }
    
    
    
    btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"chooser-button-input"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    __weak typeof(self) weakSelf = self;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.view);
        make.top.offset(100);
        make.height.with.offset(30);
    }];
}
-(void)click:(UIButton*)sender
{
    
    if (sender.selected == YES) {
        sender.selected = NO;
        NSLog(@"开");
        btn.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:0.2f animations:^{
            btn.transform = CGAffineTransformMakeRotation(M_PI);
        }];
        
        for (int i = 0; i<btnArr.count; i++) {
            UIButton*button = btnArr[i];
            CGFloat rotation = M_PI/6;
            CGPoint farPotion = [self createEndPointWithRadius:110 andAngel:rotation*(1+i)];
            CGPoint endPotion = [self createEndPointWithRadius:100 andAngel:rotation*(1+i)];
            CAAnimationGroup *group = [self foldAnimationFromPoint:endPotion withFarPoint:farPotion];
            [button.layer addAnimation:group forKey:@"foldAnimation"];
            button.center = self.view.center;
        }
        
        
    }else{
        NSLog(@"关");
        sender.selected = YES;
        btn.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:0.2f animations:^{
            btn.transform = CGAffineTransformMakeRotation(-M_PI*0.75f);
        }];
        for (int i = 0; i<btnArr.count; i++) {
            UIButton*button = btnArr[i];
            CGFloat rotation = M_PI/6;
            CGPoint farPotion = [self createEndPointWithRadius:110 andAngel:rotation*(1+i)];
            CGPoint nearPotin = [self createEndPointWithRadius:90 andAngel:rotation*(1+i)];
            CGPoint endPotion = [self createEndPointWithRadius:100 andAngel:rotation*(1+i)];
            CAAnimationGroup *group = [self bloomAnimationWithEndPoint:endPotion andFarPoint:farPotion andNearPoint:nearPotin];
            [button.layer addAnimation:group forKey:@"foldAnimation"];
            button.center = endPotion;
        }
    }
}
-(CGPoint)createEndPointWithRadius:(CGFloat)itemExpandRadius andAngel:(CGFloat)angel
{
    return CGPointMake(self.view.center.x-cosf(angel)*itemExpandRadius, self.view.center.y-sinf(angel)*itemExpandRadius);
}
-(CAAnimationGroup*)foldAnimationFromPoint:(CGPoint)endPoint withFarPoint:(CGPoint)farPoint
{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    anima.values = @[@(0),@(M_PI),@(M_PI*2)];
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anima.duration = 0.35f;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:endPoint];
    [path addLineToPoint:farPoint];
    [path addLineToPoint:CGPointMake(self.view.center.x, self.view.center.y)];
    
    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anima1.keyTimes = @[@(0.0f), @(0.75), @(1.0)];
    anima1.path = path.CGPath;
    anima1.duration = 0.35f;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[anima,anima1];
    group.duration = 0.35f;
    return group;
}
- (CAAnimationGroup *)bloomAnimationWithEndPoint:(CGPoint)endPoint andFarPoint:(CGPoint)farPoint andNearPoint:(CGPoint)nearPoint
{
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.values = @[@(0.0), @(- M_PI), @(- M_PI * 1.5), @(- M_PI * 2)];
    rotation.duration = 0.3f;
    rotation.keyTimes = @[@(0),@(0.3),@(0.6),@(1)];
    
    CAKeyframeAnimation *movingAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.view.center];
    [path addLineToPoint:farPoint];
    [path addLineToPoint:nearPoint];
    [path addLineToPoint:endPoint];
    movingAni.path = path.CGPath;
    movingAni.keyTimes = @[@(0.0), @(0.5), @(0.7), @(1.0)];
    movingAni.duration = 0.3f;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[rotation,movingAni];
    group.duration = 0.3f;
    return group;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
