//
//  ThirdPartyLoginTools.m
//  DuoBao
//
//  Created by hyw on 16/7/1.
//
//

#import "ThirdPartyLoginTools.h"
//#import "UserInfoUtils.h"
#import <UMSocialCore/UMSocialCore.h>
#import "WXApi.h"

@implementation ThirdPartyLoginTools


+(void)sinaLogin:(UIViewController *)controller  delegate:(id) delegate
{

    if ([WXApi isWXAppInstalled]) {
        [self loginWithPlatformName:ThirdPartyPlatformTypeSina withController:controller delegate:delegate];
    }
    else{
        NSLog(@"请安装新浪客户端");
    }
}

+(void)weChatLogin:(UIViewController *)controller delegate:(id) delegate
{
    if ([WXApi isWXAppInstalled]) {
        [self loginWithPlatformName:ThirdPartyPlatformTypeWechat withController:controller delegate:delegate];
    }
    else{
        NSLog(@"请安装微信客户端");
//        [ToastUtil toast:@"请安装微信客户端"];
    }
}

+(void)qqLogin:(UIViewController *)controller delegate:(id) delegate
{

    if ([WXApi isWXAppInstalled]) {
        [self loginWithPlatformName:ThirdPartyPlatformTypeQQ withController:controller delegate:delegate];
    }
    else{
        NSLog(@"请安装QQ客户端");
    }
}


+(void)loginWithPlatformName:(ThirdPartyPlatformType)type withController:(UIViewController *)controller  delegate:(id) delegate
{
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
        //此处调用授权的方法,你可以把下面的platformName 替换成 UMShareToSina,UMShareToTencent等
}

+(void)thirdPartyLoginWithPlatformType:(NSInteger)loginType  openId:(NSString *)openId name:(NSString *)name avatar:(NSString *)avatar sex:(NSString *)sex  birthDay:(NSString *)birthday iconUrl:(NSString*)iconUrl  controller:(UIViewController *)controller
{
    
    // 自家APP登录获取数据
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"appId"] = @(AppId);
//    params[@"uuid"] = [UserDefaultsUtils valueWithKey:kDeviceUUID];
//    params[@"openType"] = @(loginType);
//    params[@"openId"] = openId;
//    params[@"avatar"] = avatar;
//    params[@"sex"] = sex;
//    params[@"birthday"] = birthday;
//    params[@"nickname"] = name ;
//    
//    [AppUtils showProgressAlwaysWithMessage:@""];
//    
//    [YnHttp executePostRequestWithURL:URL_Main_Thirdparty_LOGIN params:params success:^(id obj) {
//        NSDictionary *dic = (NSDictionary *)obj;
//        NSInteger toBindPhone = [[dic objectForKey:@"toBindPhone"] integerValue];
//        
//        [UserDefaultsUtils saveValue:iconUrl forKey:kPortraitUrl];
//
//        [AppUtils dismissHUD];
//        
//        if (toBindPhone == 0) {
//            NSString *token = [dic objectForKey:@"token"];
//            NSString *userId = [dic objectForKey:@"userId"];
//            NSString *phoneNumber = [dic objectForKey:@"phoneNumber"];
//            NSString *nickName = [dic objectForKey:@"nickName"];
//            NSLog(@"%@",obj);
//            [UserDefaultsUtils saveValue:nickName forKey:kNickname];
//            [UserInfoUtils login:nickName token:token userId:userId phone:phoneNumber];
//            [controller dismissViewControllerAnimated:YES completion:nil];
//            [[NSNotificationCenter defaultCenter]  postNotificationName:k_NOTI_UserInfoChange object:nil];
//        }
//        else{
//            [TransactUtil startBindingPhoneWithUnionId:openId accountType:loginType avatar:avatar sex:sex birthday:birthday name:name controller:controller];
//        }
//        
//    } failed:^(id obj) {
//        
//        [AppUtils dismissHUD];
//        [AppUtils dismissHUDWithView:controller.view];
//        NSInteger errCode = [obj[@"errCode"] integerValue];
//        if (errCode == 10063) {
//            [TransactUtil startBindingPhoneWithUnionId:openId accountType:loginType avatar:avatar sex:sex birthday:birthday name:name controller:controller];
//        }
//        else{
//            NSString *err = obj[@"error"];
//            [ToastUtil toast:err];
//        }
//    }];
}

@end
