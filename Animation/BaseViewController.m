//
//  BaseViewController.m
//  Animation
//
//  Created by XinGou on 2018/1/23.
//  Copyright © 2018年 XinGou. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic , strong) UIView *demoView;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基础动画";
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"位移",@"透明度",@"缩放",@"旋转",@"背景色"];
    UIButton *lastBtn = nil;
    for (int i = 0; i<titleArr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = [UIColor yellowColor];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(30+64);
            make.height.offset(40);
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right).offset(15);
                make.width.equalTo(lastBtn);
            }else{
                make.left.offset(15);
            }
        }];
        lastBtn = btn;
    }
    [lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
    }];
    
    _demoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-100,100 ,100 )];
    _demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_demoView];
    
}
-(void)click:(UIButton*)sender
{
    switch (sender.tag) {
        case 0:
            [self positionAnimation];
            break;
            case 1:
            [self opacityAniamtion];
            break;
            case 2:
            [self scaleAnimation];
            break;
            case 3:
            [self rotateAnimation];
            break;
            case 4:
            [self backgroundAnimation];
            break;
        default:
            break;
    }
}
-(void)positionAnimation
{

    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-74)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-75)];
    animation.duration = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_demoView.layer addAnimation:animation forKey:@"positionAnimation"];
    
}
-(void)opacityAniamtion
{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anima.fromValue = [NSNumber numberWithFloat:1];
    anima.toValue = [NSNumber numberWithFloat:0.2];
    anima.repeatDuration =2;
    anima.duration = 1;
    anima.autoreverses = YES;
    [_demoView.layer addAnimation:anima forKey:@"opacityAnimat"];
}
-(void)scaleAnimation
{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima.toValue = [NSNumber numberWithFloat:0.2];
    anima.duration = 1;
    [_demoView.layer addAnimation:anima forKey:@"scaleAnimation"];
}
-(void)rotateAnimation
{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anima.toValue = [NSNumber numberWithFloat:M_PI];
    anima.duration = 1;
    [_demoView.layer addAnimation:anima forKey:@"rotationAnimation"];
}
-(void)backgroundAnimation
{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anima.toValue = (id)[UIColor yellowColor].CGColor;
    anima.duration = 1;
    [_demoView.layer addAnimation:anima forKey:@"color"];
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
