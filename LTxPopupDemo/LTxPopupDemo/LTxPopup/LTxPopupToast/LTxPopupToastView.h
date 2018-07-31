//
//  LTxPopupToastView.h
//  LTxPopupToast
//
//  Created by liangtong on 2018/7/30.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTxPopupHelper.h"

@class LTxPopupToastView;
@class LTxPopupToastConfiguration;

/**
 * ToastView.
 **/
@interface LTxPopupToastView : UIView

@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) UIButton* ignoreBtn;
@property (nonatomic, strong) UILabel* titleL;
@property (nonatomic, strong) UILabel* messageL;
@property (nonatomic, copy) LTxPopupCallback showCallback;
@property (nonatomic, copy) LTxPopupCallback tapCallback;
@property (nonatomic, copy) LTxPopupCallback dismissCallback;

+(instancetype)instanceWithConfiguration:(LTxPopupToastConfiguration*)configuration;

@end


@interface LTxPopupToastConfiguration : NSObject

/**
 * show under status bar
 **/
@property (nonatomic, assign) BOOL showUnderStatusBar;

/**
 * background color
 **/
@property (nonatomic, strong) UIColor* backgroundColor;

/**
 * image on the left of toast. nil means no image
 **/
@property (nonatomic, strong) UIImage* image;

/**
 * ignore btn. title color and font
 **/
@property (nonatomic, assign) BOOL showIgnoreBtn;
@property (nonatomic, strong) NSString* ignoreBtnTitle;
@property (nonatomic, strong) UIColor* ignroeBtnTitleColor;
@property (nonatomic, assign) CGFloat ignoreBtnTitleFontSize;

/**
 * title
 **/
@property (nonatomic, strong) NSString* title;
@property (nonatomic, assign) NSTextAlignment titleTextAlignment;
@property (nonatomic, strong) UIColor* titleColor;
@property (nonatomic, assign) CGFloat titleFontSize;

/**
 * message
 **/
@property (nonatomic, strong) NSString* message;
@property (nonatomic, assign) NSTextAlignment messageTextAlignment;
@property (nonatomic, strong) UIColor* messageColor;
@property (nonatomic, assign) CGFloat messageFontSize;

/**
 * animating
 **/
@property (nonatomic, assign) CGFloat showAnimateDuration;
@property (nonatomic, assign) CGFloat showDuration;
@property (nonatomic, assign) BOOL autoDismiss;

/**
 * @brief: init method. also you can use alloc and init method.
 **/
+(instancetype)defaultConfiguration;
@end
