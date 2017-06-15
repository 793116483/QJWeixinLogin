//
//  ViewController.m
//  QJWeixinLogin
//
//  Created by 瞿杰 on 2017/6/15.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    
    UIButton * weixinLogin = [[UIButton alloc] init];
    [weixinLogin setTitle:@"微信登录" forState:UIControlStateNormal];
    [weixinLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    weixinLogin.backgroundColor = [UIColor whiteColor];
    [weixinLogin addTarget:self action:@selector(weixinLoginBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:weixinLogin];
    weixinLogin.bounds = CGRectMake(0, 0, 100, 100);
    weixinLogin.center = self.view.center ;
    
}


-(void)weixinLoginBtnDidClicked
{
    NSLog(@"weixinLoginBtnDidClicked");
}


@end
