//
//  ViewController.m
//  QJWeixinLogin
//
//  Created by 瞿杰 on 2017/6/15.
//  Copyright © 2017年 yiniu. All rights reserved.
//

#import "ViewController.h"

#import "ThirdPartyLoginTools.h"
#import "UIImageView+QJWebImage.h"

@interface ViewController ()<ThirdPartyLoginToolsDelegate>

@property (nonatomic , strong)UIImageView * imageView ;
@property (nonatomic , strong)UILabel * nameLabel ;
@property (nonatomic , strong)UILabel * sexLabel ;

@property (nonatomic , strong)UIButton * weixinLogin ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    
    [self setUpViews];
}

-(void)setUpViews
{
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = CGRectMake(100, 100, 100, 100);
    self.imageView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.imageView];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.backgroundColor = [UIColor whiteColor];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.frame = CGRectMake(100, 210, 100, 50);
    self.nameLabel.text = [NSString stringWithFormat:@"用户名：xxx"];
    [self.view addSubview:self.nameLabel];
    
    self.sexLabel = [[UILabel alloc] init];
    self.sexLabel.backgroundColor = [UIColor whiteColor];
    self.sexLabel.textColor = [UIColor blackColor];
    self.sexLabel.frame = CGRectMake(100, 270, 100, 50);
    self.sexLabel.text = [NSString stringWithFormat:@"性别：x"];
    [self.view addSubview:self.sexLabel];
    
    
    UIButton * weixinLogin = [[UIButton alloc] init];
    self.weixinLogin = weixinLogin ;
    [weixinLogin setTitle:@"微信登录" forState:UIControlStateNormal];
    [weixinLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    weixinLogin.backgroundColor = [UIColor whiteColor];
    [weixinLogin addTarget:self action:@selector(weixinLoginBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:weixinLogin];
    weixinLogin.frame = CGRectMake(100, 380, 100, 100);
}


-(void)weixinLoginBtnDidClicked
{
    NSLog(@"weixinLoginBtnDidClicked");
    [ThirdPartyLoginTools weChatLogin:self delegate:self];
}

#pragma mark - ThirdPartyLoginToolsDelegate
-(void)loginToolsWithUserMessgate:(UMSocialUserInfoResponse *)response
{
    [self.imageView qj_setImageWithUrlStr:response.iconurl];
    self.nameLabel.text = [NSString stringWithFormat:@"用户名：%@",response.name];
    self.sexLabel.text = [NSString stringWithFormat:@"性别：%@",response.gender];
}

@end
