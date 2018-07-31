//
//  LTxPopupHelper.h
//  LTxPopup
//
//  Created by liangtong on 2018/7/31.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, LTxPopupShowAnimation){
    LTxPopupShowAnimationAppear,
    LTxPopupShowAnimationFadeIn,
    LTxPopupShowAnimationFromTop,
    LTxPopupShowAnimationFromRight,
    LTxPopupShowAnimationFromBottom,
    LTxPopupShowAnimationFromLeft
};

typedef NS_ENUM(NSInteger, LTxPopupHideAnimation){
    LTxPopupHideAnimationDisappear,
    LTxPopupHideAnimationFadeOut,
    LTxPopupHideAnimationOutToTop,
    LTxPopupHideAnimationOutToRight,
    LTxPopupHideAnimationOutToBottom,
    LTxPopupHideAnimationOutToLeft
};

typedef void (^LTxPopupCallback)(void);

/**
 * Helper
 **/
@interface UIView (LTxPopupHelper)

-(void)ltx_showPopup:(UIView*)popup animateType:(LTxPopupShowAnimation)animateType duration:(CGFloat)duration complete:(LTxPopupCallback)complete;

-(void)ltx_hidePopup:(UIView*)popup animateType:(LTxPopupHideAnimation)animateType duration:(CGFloat)duration complete:(LTxPopupCallback)complete;

@end
