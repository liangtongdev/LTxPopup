//
//  LTxPopupHelper.m
//  LTxPopup
//
//  Created by liangtong on 2018/7/31.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import "LTxPopupHelper.h"

@implementation UIView (LTxPopupHelper)

-(void)ltx_showPopup:(UIView*)popup animateType:(LTxPopupShowAnimation)animateType duration:(CGFloat)duration complete:(LTxPopupCallback)complete{
    if (animateType == LTxPopupShowAnimationAppear) {
        if (complete) {
            complete();
        }
    }else if (animateType == LTxPopupShowAnimationFadeIn){

        popup.alpha = 0.f;
        [UIView animateWithDuration:duration delay:0.1 usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            popup.alpha = 1.f;
        } completion:^(BOOL finished) {
            if (complete) {
                complete();
            }
        }];
    }else if (animateType == LTxPopupShowAnimationFromTop || animateType == LTxPopupShowAnimationFromRight || animateType == LTxPopupShowAnimationFromBottom || animateType == LTxPopupShowAnimationFromLeft ){
        CGRect toRect = popup.frame;
        CGRect fromRect = CGRectZero;
        if (animateType == LTxPopupShowAnimationFromTop) {
            fromRect = CGRectOffset(toRect, 0, -(toRect.size.height + toRect.origin.y));
        }else if (animateType == LTxPopupShowAnimationFromRight) {
            fromRect = CGRectOffset(toRect, (self.frame.size.width + toRect.size.width), 0);
        }else if (animateType == LTxPopupShowAnimationFromBottom) {
            fromRect = CGRectOffset(toRect, 0, (self.frame.size.height + toRect.size.height));
        }else if (animateType == LTxPopupShowAnimationFromLeft) {
            fromRect = CGRectOffset(toRect, -(toRect.size.width + toRect.origin.x), 0);
        }
        
        popup.frame = fromRect;
        [UIView animateWithDuration:duration delay:0.2 usingSpringWithDamping:0.9 initialSpringVelocity:0.1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            popup.frame = toRect;
        } completion:^(BOOL finished) {
            if (complete) {
                complete();
            }
        }];
        
    }
}

-(void)ltx_hidePopup:(UIView*)popup animateType:(LTxPopupHideAnimation)animateType duration:(CGFloat)duration complete:(LTxPopupCallback)complete{
    
    if (animateType == LTxPopupHideAnimationDisappear) {
        [popup removeFromSuperview];
        if (complete) {
            complete();
        }
    }else if (animateType == LTxPopupHideAnimationFadeOut){
        [UIView animateWithDuration:duration delay:0.1 usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            popup.alpha = 0.f;
        } completion:^(BOOL finished) {
            [popup removeFromSuperview];
            if (complete) {
                complete();
            }
        }];
    }else if (animateType == LTxPopupHideAnimationOutToTop || animateType == LTxPopupHideAnimationOutToRight || animateType == LTxPopupHideAnimationOutToBottom || animateType == LTxPopupHideAnimationOutToLeft ){
        CGRect toRect = popup.frame;
        if (animateType == LTxPopupHideAnimationOutToTop) {
            toRect = CGRectOffset(toRect, 0, -(toRect.size.height + toRect.origin.y));
        }else if (animateType == LTxPopupHideAnimationOutToRight) {
            toRect = CGRectOffset(toRect, (self.frame.size.width + toRect.size.width), 0);
        }else if (animateType == LTxPopupHideAnimationOutToBottom) {
            toRect = CGRectOffset(toRect, 0, (self.frame.size.height + toRect.size.height));
        }else if (animateType == LTxPopupHideAnimationOutToLeft) {
            toRect = CGRectOffset(toRect, -(toRect.size.width + toRect.origin.x), 0);
        }
        [UIView animateWithDuration:duration delay:0.2 usingSpringWithDamping:0.9 initialSpringVelocity:0.1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            popup.frame = toRect;
        } completion:^(BOOL finished) {
            [popup removeFromSuperview];
            if (complete) {
                complete();
            }
        }];
    }
}
@end
