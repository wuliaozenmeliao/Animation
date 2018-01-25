//
//  TransitionViewController.m
//  Animation
//
//  Created by XinGou on 2018/1/24.
//  Copyright © 2018年 XinGou. All rights reserved.
//

#import "TransitionViewController.h"

@interface TransitionViewController ()

{
    UIView *_demoView;
}
@property (nonatomic , assign) NSInteger index;
@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _index = 0;
    _demoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-90, SCREEN_HEIGHT/2-100,180,260)];
    _demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_demoView];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat btnWidth = (SCREEN_WIDTH-150)/4;
    CGFloat btnHeight = 40;
    NSArray *titleArr = [NSArray arrayWithObjects:@"fade",@"moveIn",@"push",@"reveal",@"cube",@"suck",@"oglFlip",@"ripple",@"Curl",@"UnCurl",@"caOpen",@"caClose", nil];
    for (int i = 0; i<titleArr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor yellowColor];
        btn.tag = i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(i%4*(30+btnWidth)+30);
            make.top.offset(i/4*(30+btnHeight)+64);
            make.height.offset(btnHeight);
            make.width.offset(btnWidth);
        }];
    }
    [self changeView:YES];
}
-(void)changeView : (BOOL)isUp{
    if (_index>3) {
        _index = 0;
    }
    if (_index<0) {
        _index = 3;
    }
    NSArray *colors = [NSArray arrayWithObjects:[UIColor cyanColor],[UIColor magentaColor],[UIColor orangeColor],[UIColor purpleColor], nil];
    _demoView.backgroundColor = [colors objectAtIndex:_index];
    if (isUp) {
        _index++;
    }else{
        _index--;
    }
}

-(void)click:(UIButton*)sender
{
    switch (sender.tag) {
        case 0:
            [self fadeAnimation];
            break;
            case 1:
            [self moveInAnimation];
            break;
            case 2:
            [self pushAnimation];
            break;
            case 3:
            [self revealAnimation];
            break;
            case 4:
            [self cubeAnimation];
            break;
            case 5:
            [self suckEffectAnimation];
            break;
            case 6:
            [self oglFlipAnimation];
            break;
            case 7:
            [self rippleEffectAnimation];
            break;
            case 8:
            [self pageCurlAnimation];
            break;
            case 9:
            [self pageUnCurlAnimation];
            break;
            case 10:
            [self cameraIrisHollowOpenAnimation];
            break;
            case 11:
            [self cameraIrisHollowCloseAnimation];
        default:
            break;
    }
}
-(void)pageUnCurlAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"pageUnCurl";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"pageUnCurlAnimation"];
}

-(void)cameraIrisHollowOpenAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"cameraIrisHollowOpen";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"cameraIrisHollowOpenAnimation"];
}

-(void)cameraIrisHollowCloseAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"cameraIrisHollowClose";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"cameraIrisHollowCloseAnimation"];
}

-(void)pageCurlAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"pageCurl";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"pageCurlAnimation"];
}
-(void)rippleEffectAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"rippleEffect";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"rippleEffectAnimation"];
}
-(void)fadeAnimation
{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionFade;
    anima.subtype = kCATransitionFromLeft;
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"fadeAnimation"];
}
-(void)moveInAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionMoveIn;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"moveInAnimation"];
}
-(void)pushAnimation
{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionPush;
    anima.subtype = kCATransitionFromLeft;
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"fadeAnimation"];
}
-(void)revealAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionReveal;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"revealAnimation"];
}
/**
 *  立体翻滚效果
 */
-(void)cubeAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"cube";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"revealAnimation"];
}
-(void)suckEffectAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"suckEffect";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"suckEffectAnimation"];
}
-(void)oglFlipAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"oglFlip";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"oglFlipAnimation"];
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
