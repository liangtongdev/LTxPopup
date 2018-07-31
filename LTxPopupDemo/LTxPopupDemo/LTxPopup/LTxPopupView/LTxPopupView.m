//
//  UIViewController+LTxPopupView.m
//  LTxPopupView
//
//  Created by liangtong on 2018/7/27.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import "LTxPopupView.h"


@interface LTxPopupViewContainerView : UIView

@property (nonatomic, copy) LTxPopupCallback dismissCallback;
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
        [self ltx_hidePopup:popView animateType:configuration.hideAnimationType duration:configuration.hideAnimationDuration complete:^{
            
        }];
    };
    [self addSubview:containerView];
    
    [self ltx_configPopupView:popView configuration:configuration];
    
    [self addSubview:popView];
    [self ltx_showPopup:popView animateType:configuration.showAnimationType duration:configuration.showAnimationDuration complete:^{
        
    }];
    
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
@end
