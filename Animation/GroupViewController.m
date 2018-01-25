//
//  GroupViewController.m
//  Animation
//
//  Created by XinGou on 2018/1/23.
//  Copyright © 2018年 XinGou. All rights reserved.
//

#import "GroupViewController.h"

@interface GroupViewController ()
@property (nonatomic , strong) UIView *demoView;
@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"组动画";
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"同事",@"连续"];
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
            [self groupAnimation1];
            break;
            case 1:
            [self groupAnimation2];
            break;
            
        default:
            break;
    }
}
-(void)groupAnimation1
{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    anima.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    
    CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima1.fromValue = [NSNumber numberWithFloat:0.8];
    anima1.toValue = [NSNumber numberWithFloat:0.2];
    
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima2.toValue = [NSNumber numberWithFloat:M_PI*4];
    
    CAAnimationGroup *groupA = [CAAnimationGroup animation];
    groupA.animations = [NSArray arrayWithObjects:anima,anima1,anima2, nil];
    groupA.duration = 4.0f;
    [_demoView.layer addAnimation:groupA forKey:@"animat"];
    
}
-(void)groupAnimation2
{
    CFTimeInterval currentTime = CACurrentMediaTime();
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position"];
    anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-75)];
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-75)];
    anima.beginTime = currentTime;
    anima.duration = 1.0f;
    anima.fillMode = kCAFillModeForwards;
    anima.removedOnCompletion = NO;
    [_demoView.layer addAnimation:anima forKey:@"positionA"];
    
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:0.2f];
    anima2.beginTime = currentTime+1.0f;
    anima2.duration =1.0f;
    anima2.fillMode = kCAFillModeForwards;
    anima2.removedOnCompletion = NO;
    [_demoView.layer addAnimation:anima2 forKey:@"sca"];
    
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    anima3.beginTime = currentTime+2.0f;
    anima3.duration = 1.0f;
    anima3.fillMode = kCAFillModeForwards;
    anima3.removedOnCompletion = NO;
    [_demoView.layer addAnimation:anima3 forKey:@"11"];
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
