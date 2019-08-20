//
//  RHSystemCommon.m
//  RHBaseModule
//
//  Created by aicai on 2018/7/10.
//  Copyright © 2018年 aicai. All rights reserved.
//

#import "RHSystemCommon.h"

#pragma mark App版本号
RH_EXTERN void kAppVersion() {
    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark 系统版本
RH_EXTERN float kFSystemVersion() {
    return ([[[UIDevice currentDevice] systemVersion] floatValue]);
}

RH_EXTERN double kDSystemVersion(void) {
    return ([[[UIDevice currentDevice] systemVersion] doubleValue]);
}

RH_EXTERN NSString* kSSystemVersion(void) {
    return [[UIDevice currentDevice] systemVersion];
}

#pragma mark 当前系统是否大于某个版本
RH_EXTERN BOOL isIOS6(void) {
    return ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0);
}
RH_EXTERN BOOL isIOS7(void) {
    return ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0);
}
RH_EXTERN BOOL isIOS8(void) {
    return ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0);
}
RH_EXTERN BOOL isIOS9(void) {
    return ([[[UIDevice currentDevice]systemVersion]floatValue] >= 9.0);
}
RH_EXTERN BOOL isIOS10(void) {
    return ([[[UIDevice currentDevice]systemVersion]floatValue] >= 10.0);
}
RH_EXTERN BOOL isIOS11(void) {
    return ([[[UIDevice currentDevice]systemVersion]floatValue] >= 11.0);
}

RH_EXTERN BOOL isIPhoneX(void) {
    // 判断是否是iPhone X
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);
}
RH_EXTERN BOOL isIPad(void) {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}


#pragma mark AppDelegate对象
RH_EXTERN id kAppDelegateInstance(void) {
    return [[UIApplication sharedApplication] delegate];
}

#pragma mark - Application
RH_EXTERN UIApplication *kApplication(void) {
    return [UIApplication sharedApplication];
}

#pragma mark - KeyWindow
RH_EXTERN UIWindow *kKeyWindow(void) {
    return [UIApplication sharedApplication].keyWindow;
}

#pragma mark - NotiCenter
RH_EXTERN NSNotificationCenter *kNotificationCenter(void) {
    return [NSNotificationCenter defaultCenter];
}

#pragma mark - NSUserDefault
RH_EXTERN NSUserDefaults *kNSUserDefaults(void) {
    return [NSUserDefaults standardUserDefaults];
}

#pragma mark 获取当前语言
RH_EXTERN NSString *kCurrentLanguage(void) {
    return [[NSLocale preferredLanguages] objectAtIndex:0];
}

#pragma mark Library/Caches 文件路径
RH_EXTERN NSURL *kFilePath(void) {
    return [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
}

#pragma mark 获取temp路径
RH_EXTERN NSString *kPathTemp(void) {
    return NSTemporaryDirectory();
}

#pragma mark 获取沙盒 Document路径
RH_EXTERN NSString *kPathDocument(void) {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

#pragma mark 获取沙盒 Cache
RH_EXTERN NSString *kPathCache(void) {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

#pragma mark 获取沙盒 home 目录路径
RH_EXTERN NSString *kPathHome(void) {
    return NSHomeDirectory();
}

RH_EXTERN void kOpenURL(NSString *url) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

#pragma mark 复制文字内容
RH_EXTERN void kCopyContent(NSString *content) {
    [[UIPasteboard generalPasteboard] setString:content];
}

#pragma mark 复制文字内容
RH_EXTERN void kCopyContent(NSString *content);

#pragma mark 中文字体
RH_EXTERN UIFont *kCHINESE_SYSTEM(CGFloat fontSize) {
    return [UIFont fontWithName:@"Heiti SC" size:fontSize];
}

RH_EXTERN UIFont *kSystemFont(CGFloat fontSize) {
    return [UIFont systemFontOfSize:fontSize];
}

RH_EXTERN UIFont *kBoldSystemFont(CGFloat fontSize) {
    return [UIFont boldSystemFontOfSize:fontSize];
}

RH_EXTERN UIFont *kItalicSystemFont(CGFloat fontSize) {
    return [UIFont italicSystemFontOfSize:fontSize];
}

RH_EXTERN UIFont *kFont(NSString *name,CGFloat fontSize) {
    return [UIFont fontWithName:name size:fontSize];
}


#pragma mark - 图片
RH_EXTERN UIImage *kImageNamed(NSString *imageName) {
    return [UIImage imageNamed:imageName];
}

RH_EXTERN UIImage *kImageNamedAndRenderingMode(NSString *imageName, UIImageRenderingMode renderingMode) {
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:renderingMode];
}


RH_EXTERN NSIndexPath *kIndexPath(NSInteger section, NSInteger row) {
    return [NSIndexPath indexPathForRow:row inSection:section];
}


