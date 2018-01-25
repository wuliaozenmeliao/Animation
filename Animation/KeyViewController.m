//
//  KeyViewController.m
//  Animation
//
//  Created by XinGou on 2018/1/23.
//  Copyright © 2018年 XinGou. All rights reserved.
//

#import "KeyViewController.h"

@interface KeyViewController ()
@property (nonatomic , strong) UIView *demoView;
@end

@implementation KeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帧动画";
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"关键帧",@"路径",@"抖动"];
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
            [self keyFrameAnimation];
            break;
            case 1:
            [self pathAnimation];
            break;
            case 2:
            [self shakeAnimation];
            break;
        default:
            break;
    }
}
-(void)keyFrameAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"backgroundColor"];
    NSValue *value0 = (id)[UIColor yellowColor].CGColor;
    NSValue *value1 = (id)[UIColor greenColor].CGColor;
    NSValue *value2 = (id)[UIColor blueColor].CGColor;
    animation.values = [NSArray arrayWithObjects:value0,value1,value2, nil];
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAOnOrderOut];
    animation.duration = 2;
    [_demoView.layer addAnimation:animation forKey:@"color"];
}
-(void)pathAnimation
{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-100, 200, 200)];
    anima.path = path.CGPath;
    anima.duration = 2;
    [_demoView.layer addAnimation:anima forKey:@"path"];
}
-(void)shakeAnimation
{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    NSValue *value1 = [NSNumber numberWithFloat:-M_PI/180*4];
    NSValue *value2 = [NSNumber numberWithFloat:M_PI/180*4];
    NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180*4];
    anima.values = @[value1,value2,value3];
    anima.repeatCount = MAXFLOAT;
    [_demoView.layer addAnimation:anima forKey:@"anima"];
    
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
