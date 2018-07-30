//
//  UIViewController+LTxPopupView.m
//  LTxPopupView
//
//  Created by liangtong on 2018/7/27.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import "LTxPopupView.h"


@interface LTxPopupViewContainerView : UIView

@property (nonatomic, copy) LTxPopupViewCallback dismissCallback;
+(instancetype)instanceWithFrame:(CGRect)frame configuration:(LTxPopupViewConfiguration*)config;
-(void)ltx_hidePopupViewContainerView;
@end

@implementation LTxPopupViewContainerView
+(instancetype)instanceWithFrame:(CGRect)frame configuration:(LTxPopupViewConfiguration*)config{
    LTxPopupViewContainerView* _instance = [[LTxPopupViewContainerView alloc] initWithFrame:frame];
    
    _instance.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _instance.autoresizesSubviews = YES;
    
    _instance.backgroundColor = config.containerBackgroundColor?:[UIColor clearColor];
    
    //dismiss
    if (config.dismissOnTapOutside) {
        [_instance addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:_instance action:@selector(ltx_hidePopupViewContainerView)]];
    }
    
    return _instance;
}

-(void)ltx_hidePopupViewContainerView{
    [self removeFromSuperview];
    if (self.dismissCallback) {
        self.dismissCallback();
    }
}

@end

@implementation UIViewController (LTxPopupView)

-(void)showLTxPopupView:(UIView*)popView configuration:(LTxPopupViewConfiguration*)configuration{
    [self.view showLTxPopupView:popView configuration:configuration];
}

-(void)hideLTxPopupView{
    [self.view hideLTxPopupView];
}
@end



@implementation UIView (LTxPopupView)

-(void)showLTxPopupView:(UIView*)popView configuration:(LTxPopupViewConfiguration*)configuration{
    
    LTxPopupViewContainerView* containerView = [LTxPopupViewContainerView instanceWithFrame:self.bounds configuration:configuration];
    
    containerView.dismissCallback = ^{
        [self ltx_hidePopupView:popView configuration:configuration];
    };
    [self addSubview:containerView];
    
    [self ltx_configPopupView:popView configuration:configuration];
    
    [self ltx_showPopupView:popView configuration:configuration];
    
}

-(void)hideLTxPopupView{
    NSArray* subViews = self.subviews;
    for (UIView* subView in subViews) {
        if ([subView isKindOfClass:[LTxPopupViewContainerView class]]) {
            LTxPopupViewContainerView* containerView = (LTxPopupViewContainerView*)subView;
            [containerView ltx_hidePopupViewContainerView];
        }
    }
}

-(void)ltx_configPopupView:(UIView*)popView configuration:(LTxPopupViewConfiguration*)config{
    popView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    if (config.cornerSize > 0.1) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:popView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(config.cornerSize, config.cornerSize)];
        shapeLayer.path = path.CGPath;
        popView.layer.mask = shapeLayer;
    }
}

-(void)ltx_showPopupView:(UIView*)popView configuration:(LTxPopupViewConfiguration*)config{
    if (config.showAnimationType == LTxPopupViewShowAnimationAppear) {
        [self addSubview:popView];
    }else if (config.showAnimationType == LTxPopupViewShowAnimationFadeIn){
        [self addSubview:popView];
        popView.alpha = 0.f;
        [UIView animateWithDuration:config.showAnimationDuration delay:0.1 usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            popView.alpha = 1.f;
        } completion:^(BOOL finished) {
        }];
    }else if (config.showAnimationType == LTxPopupViewShowAnimationFromTop || config.showAnimationType == LTxPopupViewShowAnimationFromRight || config.showAnimationType == LTxPopupViewShowAnimationFromBottom || config.showAnimationType == LTxPopupViewShowAnimationFromLeft ){
        CGRect toRect = popView.frame;
        CGRect fromRect = CGRectZero;
        if (config.showAnimationType == LTxPopupViewShowAnimationFromTop) {
            fromRect = CGRectOffset(toRect, 0, -(toRect.size.height + toRect.origin.y));
        }else if (config.showAnimationType == LTxPopupViewShowAnimationFromRight) {
            fromRect = CGRectOffset(toRect, (self.frame.size.width + toRect.size.width), 0);
        }else if (config.showAnimationType == LTxPopupViewShowAnimationFromBottom) {
            fromRect = CGRectOffset(toRect, 0, (self.frame.size.height + toRect.size.height));
        }else if (config.showAnimationType == LTxPopupViewShowAnimationFromLeft) {
            fromRect = CGRectOffset(toRect, -(toRect.size.width + toRect.origin.x), 0);
        }
        
        [self addSubview:popView];
        popView.frame = fromRect;
        [UIView animateWithDuration:config.showAnimationDuration delay:0.2 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            popView.frame = toRect;
        } completion:^(BOOL finished) {
        }];
        
    }
}

-(void)ltx_hidePopupView:(UIView*)popView configuration:(LTxPopupViewConfiguration*)config{
    if (config.hideAnimationType == LTxPopupViewHideAnimationDisappear) {
        [popView removeFromSuperview];
    }else if (config.hideAnimationType == LTxPopupViewHideAnimationFadeOut){
        [UIView animateWithDuration:config.hideAnimationDuration delay:0.1 usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            popView.alpha = 0.f;
        } completion:^(BOOL finished) {
            [popView removeFromSuperview];
        }];
    }else if (config.hideAnimationType == LTxPopupViewHideAnimationOutToTop || config.hideAnimationType == LTxPopupViewHideAnimationOutToRight || config.hideAnimationType == LTxPopupViewHideAnimationOutToBottom || config.hideAnimationType == LTxPopupViewHideAnimationOutToLeft ){
        CGRect toRect = popView.frame;
        if (config.hideAnimationType == LTxPopupViewHideAnimationOutToTop) {
            toRect = CGRectOffset(toRect, 0, -(toRect.size.height + toRect.origin.y));
        }else if (config.hideAnimationType == LTxPopupViewHideAnimationOutToRight) {
            toRect = CGRectOffset(toRect, (self.frame.size.width + toRect.size.width), 0);
        }else if (config.hideAnimationType == LTxPopupViewHideAnimationOutToBottom) {
            toRect = CGRectOffset(toRect, 0, (self.frame.size.height + toRect.size.height));
        }else if (config.hideAnimationType == LTxPopupViewHideAnimationOutToLeft) {
            toRect = CGRectOffset(toRect, -(toRect.size.width + toRect.origin.x), 0);
        }
        [UIView animateWithDuration:config.hideAnimationDuration delay:0.2 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            popView.frame = toRect;
        } completion:^(BOOL finished) {
            [popView removeFromSuperview];
        }];
    }
}
@end
