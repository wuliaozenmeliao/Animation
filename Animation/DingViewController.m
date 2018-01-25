//
//  DingViewController.m
//  Animation
//
//  Created by XinGou on 2018/1/25.
//  Copyright © 2018年 XinGou. All rights reserved.
//

#import "DingViewController.h"

@interface DingViewController ()
{
    NSMutableArray *btnArr;
}
@end

@implementation DingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    btnArr=[[NSMutableArray alloc] init];
    
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *centerBtn = [[UIButton alloc] init];
    [centerBtn setTitle:@"Tap" forState:UIControlStateNormal];
    [centerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    centerBtn.backgroundColor = [UIColor lightGrayColor];
    centerBtn.layer.masksToBounds = YES;
    centerBtn.layer.cornerRadius = 25;
    [centerBtn addTarget:self action:@selector(tapClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:centerBtn];
    __weak typeof(self) weakSelf = self;
    [centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.offset(-40);
        make.center.equalTo(weakSelf.view);
        make.height.width.offset(50);
    }];
    
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"A",@"B", @"C", @"D", @"E",nil];
    for (int i = 0; i<titleArr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = [UIColor lightGrayColor];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 20;
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.offset(40);
            make.center.equalTo(centerBtn);
        }];
        [btnArr addObject:btn];
    }
    [self.view bringSubviewToFront:centerBtn];
    
}
-(void)tapClick:(UIButton*)sender
{
    if (sender.selected == YES) {
        NSLog(@"关");
        CFTimeInterval currentTime = CACurrentMediaTime();
        for (int i = 0; i<btnArr.count; i++) {
            UIButton *btn = btnArr[btnArr.count-i-1];
            CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            anima1.fromValue = [NSNumber numberWithFloat:1.0f];
            anima1.toValue = [NSNumber numberWithFloat:0.1f];
            anima1.fillMode = kCAFillModeForwards;
            anima1.removedOnCompletion = NO;
            anima1.duration = 0.3;
            anima1.beginTime = currentTime + (0.3/btnArr.count*(i));
            [btn.layer addAnimation:anima1 forKey:@"22"];
            btn.transform = CGAffineTransformMakeScale(1, 1);
            CGPoint endPotion = CGPointMake(self.view.center.x, self.view.center.y-(25+10+20)*(i+1));
            CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position"];
            anima.fromValue = [NSValue valueWithCGPoint:endPotion];
            anima.toValue = [NSValue valueWithCGPoint:self.view.center];
            anima.duration = 0.3f;
            anima.beginTime = currentTime + (0.3/btnArr.count*(i))+0.03;
            anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            anima.fillMode = kCAFillModeForwards;
            anima.removedOnCompletion = NO;
            [btn.layer addAnimation:anima forKey:@"111"];
            
        }
        sender.selected = NO;
    }else{
        NSLog(@"开");
        sender.selected = YES;
        CFTimeInterval currentTime = CACurrentMediaTime();
        for (int i =0; i<btnArr.count; i++) {
            UIButton *btn = btnArr[btnArr.count-i-1];
            btn.transform = CGAffineTransformIdentity;
            CGPoint endPotion = CGPointMake(self.view.center.x, self.view.center.y-(25+10+20)*(i+1));
            CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position"];
            anima.fromValue = [NSValue valueWithCGPoint:self.view.center];
            anima.toValue = [NSValue valueWithCGPoint:endPotion];
            anima.duration = 0.3f;
            anima.beginTime = currentTime + (0.3/btnArr.count*(btnArr.count-i-1));
            anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            anima.fillMode = kCAFillModeForwards;
            anima.removedOnCompletion = NO;
            [btn.layer addAnimation:anima forKey:@"111"];
            CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            anima1.fromValue = [NSNumber numberWithFloat:0.1f];
            anima1.toValue = [NSNumber numberWithFloat:1.0f];
            anima1.fillMode = kCAFillModeForwards;
            anima1.removedOnCompletion = NO;
            anima1.beginTime = currentTime + (0.3/btnArr.count*(btnArr.count-i-1))+0.03;
            [btn.layer addAnimation:anima1 forKey:@"22"];
            btn.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
            btn.center = endPotion;
        }
    }
}
-(void)openGroupAnimationWithFromPoitn:(CGPoint)beginPotion toPotion:(CGPoint)toPotion
{
    
    
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
