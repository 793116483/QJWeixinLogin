//
//  ThirdPartyLoginTools.m
//  DuoBao
//
//  Created by 瞿杰 on 17/6/15.
//
//

#import "ThirdPartyLoginTools.h"
//#import "UserInfoUtils.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>

@implementation ThirdPartyLoginTools


+(void)sinaLogin:(UIViewController *)controller  delegate:(id<ThirdPartyLoginToolsDelegate>) delegate
{

    if ([WeiboSDK isWeiboAppInstalled]) {
        [self loginWithPlatformName:ThirdPartyPlatformTypeSina withController:controller delegate:delegate];
    }
    else{
        NSLog(@"请安装新浪客户端");
    }
}

+(void)weChatLogin:(UIViewController *)controller delegate:(id<ThirdPartyLoginToolsDelegate>) delegate
{
    if ([WXApi isWXAppInstalled]) {
        [self loginWithPlatformName:ThirdPartyPlatformTypeWechat withController:controller delegate:delegate];
    }
    else{
        NSLog(@"请安装微信客户端");
//        [ToastUtil toast:@"请安装微信客户端"];
    }
}

+(void)qqLogin:(UIViewController *)controller delegate:(id<ThirdPartyLoginToolsDelegate>) delegate
{

    if ([TencentOAuth iphoneQQInstalled]) {
        [self loginWithPlatformName:ThirdPartyPlatformTypeQQ withController:controller delegate:delegate];
    }
    else{
        NSLog(@"请安装QQ客户端");
    }
}


+(void)loginWithPlatformName:(ThirdPartyPlatformType)type withController:(UIViewController *)controller  delegate:(id<ThirdPartyLoginToolsDelegate>) delegate
{
    //此处调用授权的方法,你可以把下面的platformName 替换成 UMShareToSina,UMShareToTencent等
    UMSocialPlatformType platformName  ;

    if (ThirdPartyPlatformTypeWechat == type) {
        platformName = UMSocialPlatformType_WechatSession ;
    }
    else if (ThirdPartyPlatformTypeQQ == type){
        platformName = UMSocialPlatformType_QQ ;
    }
    else{
        platformName = UMSocialPlatformType_Sina ;
    }
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformName currentViewController:controller completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            if ([delegate respondsToSelector:@selector(loginToolsWithUserMessgate:)]) {
                [delegate loginToolsWithUserMessgate:resp];
            }
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.gender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            
            [self thirdPartyLoginWithPlatformType:type openId:resp.uid name:resp.name avatar:resp.iconurl sex:[NSString stringWithFormat:@"%ld",[[resp.originalResponse objectForKey:@"sex"] integerValue]] birthDay:nil iconUrl:resp.iconurl controller:controller];
        }
    }];
}

+(void)thirdPartyLoginWithPlatformType:(NSInteger)loginType  openId:(NSString *)openId name:(NSString *)name avatar:(NSString *)avatar sex:(NSString *)sex  birthDay:(NSString *)birthday iconUrl:(NSString*)iconUrl  controller:(UIViewController *)controller
{
    
    // 自家APP登录获取数据
}

@end
