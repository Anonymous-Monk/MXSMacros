//
//  RHSystemCommon.h
//  RHBaseModule
//
//  Created by aicai on 2018/7/10.
//  Copyright © 2018年 aicai. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "RHCommon.h"

RH_EXTERN_C_BEGIN

#pragma mark App版本号
RH_EXTERN void kAppVersion(void);

#pragma mark 系统版本
RH_EXTERN float kFSystemVersion(void);
RH_EXTERN double kDSystemVersion(void);
RH_EXTERN NSString* kSSystemVersion(void);

#pragma mark 当前系统是否大于某个版本
RH_EXTERN BOOL isIOS6(void);
RH_EXTERN BOOL isIOS7(void);
RH_EXTERN BOOL isIOS8(void);
RH_EXTERN BOOL isIOS9(void);
RH_EXTERN BOOL isIOS10(void);
RH_EXTERN BOOL isIOS11(void);

RH_EXTERN BOOL isIPhoneX(void);
RH_EXTERN BOOL isIPad(void);

#pragma mark AppDelegate对象
RH_EXTERN id kAppDelegateInstance(void);

#pragma mark - Application
RH_EXTERN UIApplication *kApplication(void);

#pragma mark - KeyWindow
RH_EXTERN UIWindow *kKeyWindow(void);

#pragma mark - NotiCenter
RH_EXTERN NSNotificationCenter *kNotificationCenter(void);

#pragma mark - NSUserDefault
RH_EXTERN NSUserDefaults *kNSUserDefaults(void);

#pragma mark 获取当前语言
RH_EXTERN NSString *kCurrentLanguage(void);

#pragma mark Library/Caches 文件路径
RH_EXTERN NSURL *kFilePath(void);

#pragma mark 获取temp路径
RH_EXTERN NSString *kPathTemp(void);

#pragma mark 获取沙盒 Document路径
RH_EXTERN NSString *kPathDocument(void);

#pragma mark 获取沙盒 Cache
RH_EXTERN NSString *kPathCache(void);

#pragma mark 获取沙盒 home 目录路径
RH_EXTERN NSString *kPathHome(void);

#pragma mark 用safari打开URL
RH_EXTERN void kOpenURL(NSString *url);

#pragma mark 复制文字内容
RH_EXTERN void kCopyContent(NSString *content);

#pragma mark 中文字体
RH_EXTERN UIFont *kCHINESE_SYSTEM(CGFloat fontSize);
RH_EXTERN UIFont *kSystemFont(CGFloat fontSize);
RH_EXTERN UIFont *kBoldSystemFont(CGFloat fontSize);
RH_EXTERN UIFont *kItalicSystemFont(CGFloat fontSize);
RH_EXTERN UIFont *kFont(NSString *name,CGFloat fontSize);


#pragma mark - 图片
RH_EXTERN UIImage *kImageNamed(NSString *imageName);
RH_EXTERN UIImage *kImageNamedAndRenderingMode(NSString *imageName, UIImageRenderingMode renderingMode);

#pragma mark - NSIndexPath
RH_EXTERN NSIndexPath *kIndexPath(NSInteger section, NSInteger row);




RH_EXTERN_C_END
