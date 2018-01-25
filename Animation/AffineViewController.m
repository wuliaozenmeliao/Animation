//
//  AffineViewController.m
//  Animation
//
//  Created by XinGou on 2018/1/24.
//  Copyright © 2018年 XinGou. All rights reserved.
//

#import "AffineViewController.h"

@interface AffineViewController ()
{
    UIView *_demoView;
}
@end

@implementation AffineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"仿射变换";
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"位移",@"缩放",@"旋转",@"组合",@"反转"];
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
            [self scaleAnimation];
            break;
            case 2:
            [self retateAnimation];
            break;
            case 3:
            [self combinationAnimation];
            break;
        default:
            break;
    }
}
-(void)positionAnimation
{
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        _demoView.transform = CGAffineTransformMakeTranslation(100, 100);
    }];
}
-(void)scaleAnimation
{
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        _demoView.transform = CGAffineTransformMakeScale(2, 2);
    }];
}
-(void)retateAnimation
{
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        _demoView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}
-(void)combinationAnimation
{
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        CGAffineTransform transform1 = CGAffineTransformMakeRotation(M_PI);
        CGAffineTransform transform2 = CGAffineTransformScale(transform1, 0.5, 0.5);
        _demoView.transform = CGAffineTransformTranslate(transform2, 100, 100);
    }];
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
