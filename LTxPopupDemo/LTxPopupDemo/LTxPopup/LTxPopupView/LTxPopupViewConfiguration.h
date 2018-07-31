//
//  LTxPopupViewConfiguration.h
//  LTxPopupView
//
//  Created by liangtong on 2018/7/27.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LTxPopupHelper.h"


/**
 * Configuration for LTxPopupView
 **/
@interface LTxPopupViewConfiguration : NSObject

//container background. default is [[UIColor lightGrayColor] colorWithAlphaComponent:0.4]
@property (nonatomic, strong) UIColor* containerBackgroundColor;
//popup dismiss on tap outside. default is NO
@property (nonatomic, assign) BOOL dismissOnTapOutside;

//corner size. default is 10.f
@property (nonatomic, assign) CGFloat cornerSize;

//animation type and duration
@property (nonatomic, assign) LTxPopupShowAnimation showAnimationType;
@property (nonatomic, assign) LTxPopupHideAnimation hideAnimationType;
@property (nonatomic, assign) CGFloat showAnimationDuration;
@property (nonatomic, assign) CGFloat hideAnimationDuration;

/**
 * @brief: init method. also you can use alloc and init method.
 **/
+(instancetype)defaultConfiguration;

@end
