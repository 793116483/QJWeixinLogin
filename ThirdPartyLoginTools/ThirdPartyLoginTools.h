//
//  ThirdPartyLoginTools.h
//  DuoBao
//
//  Created by hyw on 16/7/1.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UMSocialCore/UMSocialCore.h>


typedef enum : NSUInteger {
    ThirdPartyPlatformTypeQQ = 3,
    ThirdPartyPlatformTypeWechat = 4,
    ThirdPartyPlatformTypeSina = 5,
} ThirdPartyPlatformType;


@protocol ThirdPartyLoginToolsDelegate <NSObject>

@required
-(void)loginToolsWithUserMessgate:(UMSocialUserInfoResponse *)response ;

@end


@interface ThirdPartyLoginTools : NSObject

/**
 *  新浪登陆
 *
 *  @param controller
 */
+(void)sinaLogin:(UIViewController *)controller  delegate:(id<ThirdPartyLoginToolsDelegate>) delegate;
/**
 *  微信登陆
 *
 *  @param controller
 */
+(void)weChatLogin:(UIViewController *)controller delegate:(id<ThirdPartyLoginToolsDelegate>) delegate;
/**
 *  QQ登陆
 *
 *  @param controller
 */

+(void)qqLogin:(UIViewController *)controller delegate:(id<ThirdPartyLoginToolsDelegate>) delegate;

/**
 *
 * 登陆
 *  @param platformName 平台名字
 *  @param controller
 */
+(void)loginWithPlatformName:(ThirdPartyPlatformType)type withController:(UIViewController *)controller  delegate:(id<ThirdPartyLoginToolsDelegate>) delegate;

/**
 *  第三方授权成功，登陆接口
 *
 *  @param loginType  登陆类型
 *  @param openId     第三方唯一标识
 *  @param avatar     头像地址
 *  @param sex        性别
 *  @param birthday   生日
 *  @param controller 
 */
+(void)thirdPartyLoginWithPlatformType:(NSInteger)loginType  openId:(NSString *)openId name:(NSString *)name avatar:(NSString *)avatar sex:(NSString *)sex  birthDay:(NSString *)birthday iconUrl:(NSString*)iconUrl  controller:(UIViewController *)controller;
@end
