//
//  RHCGCommon.m
//  RHBaseModule
//
//  Created by aicai on 2018/7/10.
//  Copyright © 2018年 aicai. All rights reserved.
//

#import "RHCGCommon.h"
#import <Accelerate/Accelerate.h>
#import "RHSystemCommon.h"

RH_EXTERN CGFloat rhScreenScale() {
    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
    });
    return scale;
}

RH_EXTERN CGRect rhScrentBounds(void) {
    return [[UIScreen mainScreen] bounds];
}

RH_EXTERN CGSize rhScreenSize() {
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.height < size.width) {
            CGFloat tmp = size.height;
            size.height = size.width;
            size.width = tmp;
        }
    });
    return size;
}


RH_EXTERN CGFloat rhScreenWidth(void) {
    return (([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height;
}
RH_EXTERN CGFloat rhScreenHeight(void) {
    return ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width);
}


RH_EXTERN CGFloat rhScreenWidthRatio(void) {
    return rhScreenWidth() / 375.0;
}

RH_EXTERN CGFloat rhScreenHeightRatio(void) {
    return rhScreenHeight() / 667.0;
}

RH_EXTERN CGFloat rhAdaptedWidth(CGFloat width) {
    return (CGFloat)ceilf(width) * rhScreenWidthRatio();
}

RH_EXTERN CGFloat rhAdaptedHeight(CGFloat height) {
    return (CGFloat)ceilf(height) * rhScreenHeightRatio();
}


RH_EXTERN UIFont * rhAdaptedFontSize(CGFloat fontSize) {
    return rhCHINESE_SYSTEM(kAdaptedWidth(fontSize));
}


//导航栏高度
RH_EXTERN CGFloat rhNaviBarHeight(void) {
    return 44.0;
}

//状态栏高度
RH_EXTERN CGFloat rhStatusBarHeight(void) {
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

//导航栏与状态栏高度
RH_EXTERN CGFloat rhStatusBarAndNavigationBarHeight(void) {
    return rhNaviBarHeight() + rhStatusBarHeight();
}

//tabbar高度
RH_EXTERN CGFloat rhTabbarHeight(void) {
    return [[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49;
}


// iOS 11.0 的 view.safeAreaInsets
RH_EXTERN UIEdgeInsets rhViewSafeAreaInsets(UIView *view) {
    UIEdgeInsets i;
    if(@available(iOS 11.0, *)) {
        i = view.safeAreaInsets;
    } else {
        i = UIEdgeInsetsZero;
    }
    return i;
}

// iOS 11 一下的 scrollview 的适配
RH_EXTERN void rhAdjustsScrollViewInsetNever(UIViewController *controller, UIScrollView *view) {
    if(@available(iOS 11.0, *)) {
        view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else if([controller isKindOfClass:[UIViewController class]]) {
        controller.automaticallyAdjustsScrollViewInsets = false;
    }
}


RH_EXTERN CGContextRef RHCGContextCreateARGBBitmapContext(CGSize size, BOOL opaque, CGFloat scale) {
    size_t width = ceil(size.width * scale);
    size_t height = ceil(size.height * scale);
    if (width < 1 || height < 1) return NULL;
    
    //pre-multiplied ARGB, 8-bits per component
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGImageAlphaInfo alphaInfo = (opaque ? rhCGImageAlphaNoneSkipFirst : rhCGImageAlphaPremultipliedFirst);
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, space, rhCGBitmapByteOrderDefault | alphaInfo);
    CGColorSpaceRelease(space);
    if (context) {
        CGContextTranslateCTM(context, 0, height);
        CGContextScaleCTM(context, scale, -scale);
    }
    return context;
}

RH_EXTERN CGContextRef RHCGContextCreateGrayBitmapContext(CGSize size, CGFloat scale) {
    size_t width = ceil(size.width * scale);
    size_t height = ceil(size.height * scale);
    if (width < 1 || height < 1) return NULL;
    
    //DeviceGray, 8-bits per component
    CGColorSpaceRef space = CGColorSpaceCreateDeviceGray();
    CGImageAlphaInfo alphaInfo = rhCGImageAlphaNone;
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, space, rhCGBitmapByteOrderDefault | alphaInfo);
    CGColorSpaceRelease(space);
    if (context) {
        CGContextTranslateCTM(context, 0, height);
        CGContextScaleCTM(context, scale, -scale);
    }
    return context;
}


// return 0 when succeed
static int matrix_invert(__CLPK_integer N, double *matrix) {
    __CLPK_integer error = 0;
    __CLPK_integer pivot_tmp[6 * 6];
    __CLPK_integer *pivot = pivot_tmp;
    double workspace_tmp[6 * 6];
    double *workspace = workspace_tmp;
    bool need_free = false;
    
    if (N > 6) {
        need_free = true;
        pivot = malloc(N * N * sizeof(__CLPK_integer));
        if (!pivot) return -1;
        workspace = malloc(N * sizeof(double));
        if (!workspace) {
            free(pivot);
            return -1;
        }
    }
    
    dgetrf_(&N, &N, matrix, &N, pivot, &error);
    
    if (error == 0) {
        dgetri_(&N, matrix, &N, pivot, workspace, &N, &error);
    }
    
    if (need_free) {
        free(pivot);
        free(workspace);
    }
    return error;
}

RH_EXTERN UIViewContentMode RHCAGravityToUIViewContentMode(NSString *gravity) {
    static NSDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{ rhCAGravityCenter:@(UIViewContentModeCenter),
                 rhCAGravityTop:@(UIViewContentModeTop),
                 rhCAGravityBottom:@(UIViewContentModeBottom),
                 rhCAGravityLeft:@(UIViewContentModeLeft),
                 rhCAGravityRight:@(UIViewContentModeRight),
                 rhCAGravityTopLeft:@(UIViewContentModeTopLeft),
                 rhCAGravityTopRight:@(UIViewContentModeTopRight),
                 rhCAGravityBottomLeft:@(UIViewContentModeBottomLeft),
                 rhCAGravityBottomRight:@(UIViewContentModeBottomRight),
                 rhCAGravityResize:@(UIViewContentModeScaleToFill),
                 rhCAGravityResizeAspect:@(UIViewContentModeScaleAspectFit),
                 rhCAGravityResizeAspectFill:@(UIViewContentModeScaleAspectFill) };
    });
    if (!gravity) return UIViewContentModeScaleToFill;
    return (UIViewContentMode)((NSNumber *)dic[gravity]).integerValue;
}

RH_EXTERN NSString * RHUIViewContentModeToCAGravity(UIViewContentMode contentMode) {
    switch (contentMode) {
        case UIViewContentModeScaleToFill: return rhCAGravityResize;
        case UIViewContentModeScaleAspectFit: return rhCAGravityResizeAspect;
        case UIViewContentModeScaleAspectFill: return rhCAGravityResizeAspectFill;
        case UIViewContentModeRedraw: return rhCAGravityResize;
        case UIViewContentModeCenter: return rhCAGravityCenter;
        case UIViewContentModeTop: return rhCAGravityTop;
        case UIViewContentModeBottom: return rhCAGravityBottom;
        case UIViewContentModeLeft: return rhCAGravityLeft;
        case UIViewContentModeRight: return rhCAGravityRight;
        case UIViewContentModeTopLeft: return rhCAGravityTopLeft;
        case UIViewContentModeTopRight: return rhCAGravityTopRight;
        case UIViewContentModeBottomLeft: return rhCAGravityBottomLeft;
        case UIViewContentModeBottomRight: return rhCAGravityBottomRight;
        default: return rhCAGravityResize;
    }
}

RH_EXTERN CGRect RHCGRectFitWithContentMode(CGRect rect, CGSize size, UIViewContentMode mode) {
    rect = CGRectStandardize(rect);
    size.width = size.width < 0 ? -size.width : size.width;
    size.height = size.height < 0 ? -size.height : size.height;
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    switch (mode) {
        case UIViewContentModeScaleAspectFit:
        case UIViewContentModeScaleAspectFill: {
            if (rect.size.width < 0.01 || rect.size.height < 0.01 ||
                size.width < 0.01 || size.height < 0.01) {
                rect.origin = center;
                rect.size = CGSizeZero;
            } else {
                CGFloat scale;
                if (mode == UIViewContentModeScaleAspectFit) {
                    if (size.width / size.height < rect.size.width / rect.size.height) {
                        scale = rect.size.height / size.height;
                    } else {
                        scale = rect.size.width / size.width;
                    }
                } else {
                    if (size.width / size.height < rect.size.width / rect.size.height) {
                        scale = rect.size.width / size.width;
                    } else {
                        scale = rect.size.height / size.height;
                    }
                }
                size.width *= scale;
                size.height *= scale;
                rect.size = size;
                rect.origin = CGPointMake(center.x - size.width * 0.5, center.y - size.height * 0.5);
            }
        } break;
        case UIViewContentModeCenter: {
            rect.size = size;
            rect.origin = CGPointMake(center.x - size.width * 0.5, center.y - size.height * 0.5);
        } break;
        case UIViewContentModeTop: {
            rect.origin.x = center.x - size.width * 0.5;
            rect.size = size;
        } break;
        case UIViewContentModeBottom: {
            rect.origin.x = center.x - size.width * 0.5;
            rect.origin.y += rect.size.height - size.height;
            rect.size = size;
        } break;
        case UIViewContentModeLeft: {
            rect.origin.y = center.y - size.height * 0.5;
            rect.size = size;
        } break;
        case UIViewContentModeRight: {
            rect.origin.y = center.y - size.height * 0.5;
            rect.origin.x += rect.size.width - size.width;
            rect.size = size;
        } break;
        case UIViewContentModeTopLeft: {
            rect.size = size;
        } break;
        case UIViewContentModeTopRight: {
            rect.origin.x += rect.size.width - size.width;
            rect.size = size;
        } break;
        case UIViewContentModeBottomLeft: {
            rect.origin.y += rect.size.height - size.height;
            rect.size = size;
        } break;
        case UIViewContentModeBottomRight: {
            rect.origin.x += rect.size.width - size.width;
            rect.origin.y += rect.size.height - size.height;
            rect.size = size;
        } break;
        case UIViewContentModeScaleToFill:
        case UIViewContentModeRedraw:
        default: {
            rect = rect;
        }
    }
    return rect;
}

