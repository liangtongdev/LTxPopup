//
//  LTxPopupToastView.m
//  LTxPopupToast
//
//  Created by liangtong on 2018/7/30.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import "LTxPopupToastView.h"

@interface LTxPopupToastView()
@property (nonatomic, strong) UIWindow* popupWindow;
@property (nonatomic, strong) NSTimer *timer;
@end


#define LTxPopupToastViewPadding    4
#define LTxPopupToastViewImageWidth    30
#define LTxPopupToastViewButtonWidth    50
#define LTxPopupToastViewTitleHeight    20

@implementation LTxPopupToastView

+(instancetype)instanceWithConfiguration:(LTxPopupToastConfiguration*)configuration{
    LTxPopupToastView* toastView = [[LTxPopupToastView alloc] init];
    
    [toastView ltxSetupToastViewWithConfiguration:configuration];
    
    return toastView;
}


-(void)ltxSetupToastViewWithConfiguration:(LTxPopupToastConfiguration*)configuration{
    //autoresizing
//    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGRect frame = CGRectMake(0, 0, [LTxPopupToastView getStatusBarWidth], [LTxPopupToastView getStatusBarHeight] + [LTxPopupToastView getNavigationBarHeight]);
    self.frame = frame;
    
    _popupWindow = [[UIWindow alloc] initWithFrame:frame];
    if (configuration.showUnderStatusBar) {
        _popupWindow.windowLevel = UIWindowLevelNormal + 1;
    }else{
        _popupWindow.windowLevel = UIWindowLevelStatusBar;
    }
    _popupWindow.layer.masksToBounds = YES;
    _popupWindow.backgroundColor = [UIColor clearColor];
    [_popupWindow addSubview:self];
    [_popupWindow makeKeyAndVisible];
    
    
    self.backgroundColor = configuration.backgroundColor?:[UIColor colorWithRed:59/255.0 green:145/255.0 blue:233/255.0 alpha:1.f];
    
    //Background View
    _bgView = [[UIView alloc] init];
    _bgView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_bgView];
    
    //imageView
    if (configuration.image) {
        _imageView = [[UIImageView alloc] initWithImage:configuration.image];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_bgView addSubview:_imageView];
    }
    
    if (configuration.showIgnoreBtn) {
        _ignoreBtn = [[UIButton alloc] init];
        _ignoreBtn.translatesAutoresizingMaskIntoConstraints = NO;
        //title
        [_ignoreBtn setTitle:configuration.ignoreBtnTitle?:@"忽略" forState:UIControlStateNormal];
        //color
        [_ignoreBtn setTitleColor:configuration.ignroeBtnTitleColor?:[UIColor whiteColor] forState:UIControlStateNormal];
        //font
        [_ignoreBtn.titleLabel setFont:[UIFont systemFontOfSize:configuration.ignoreBtnTitleFontSize > 0 ? configuration.ignoreBtnTitleFontSize : 16]];
        //action
        [_ignoreBtn addTarget:self action:@selector(ignoreBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        
        [_bgView addSubview:_ignoreBtn];
    }
    
    //title
    if (configuration.title) {
        _titleL = [[UILabel alloc] init];
        _titleL.translatesAutoresizingMaskIntoConstraints = NO;
        _titleL.numberOfLines = 0;
        _titleL.text = configuration.title;
        _titleL.textAlignment = configuration.titleTextAlignment;
        _titleL.textColor = configuration.titleColor?:[UIColor whiteColor];
        _titleL.font = [UIFont systemFontOfSize:configuration.titleFontSize > 0 ? configuration.titleFontSize : 16];
        
        [_bgView addSubview:_titleL];
    }
    
    //message
    if (configuration.message) {
        _messageL = [[UILabel alloc] init];
        _messageL.translatesAutoresizingMaskIntoConstraints = NO;
        _messageL.numberOfLines = 0;
        _messageL.text = configuration.message;
        _messageL.textAlignment = configuration.messageTextAlignment;
        _messageL.textColor = configuration.messageColor?:[UIColor whiteColor];
        _messageL.font = [UIFont systemFontOfSize:configuration.messageFontSize > 0 ? configuration.messageFontSize :12.5];
        [_bgView addSubview:_messageL];
    }
    
    [self ltxAddToastViewConstraintsWithConfiguration:configuration];
    
    
    //Animationg
    [_popupWindow ltx_showPopup:self animateType:LTxPopupShowAnimationFromTop duration:configuration.showAnimateDuration complete:^{
        if (self.showCallback) {
            self.showCallback();
        }
    }];
    //AutoDismiss
    if (configuration.autoDismiss) {
        self.timer = [NSTimer timerWithTimeInterval:(configuration.showDuration + configuration.showAnimateDuration) target:self selector:@selector(ltx_hideLTxPopupToastWithTimer:) userInfo:@NO repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
    //tap gesture
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ltx_tapAtPopupToastView)]];
    
}

-(void)ltx_tapAtPopupToastView{
    [self ltx_hideLTxPopupToastWithTap:YES];
}

- (void)ltx_hideLTxPopupToastWithTimer:(NSTimer *)timer {
    [self ltx_hideLTxPopupToastWithTap:[timer.userInfo boolValue]];
}

-(void)ignoreBtnPressed{
    [self ltx_hideLTxPopupToastWithTap:NO];
}

-(void)ltx_hideLTxPopupToastWithTap:(BOOL)tap{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self.popupWindow ltx_hidePopup:self animateType:LTxPopupHideAnimationFadeOut duration:0.6 complete:^{
        [self.popupWindow removeFromSuperview];
        if (self.dismissCallback) {
            self.dismissCallback();
        }
    }];
    if (tap && self.tapCallback) {
        self.tapCallback();
    }
}

-(void)ltxAddToastViewConstraintsWithConfiguration:(LTxPopupToastConfiguration*)configuration{
    //Background View
    NSLayoutConstraint* bgLeading = [NSLayoutConstraint constraintWithItem:_bgView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.f constant:LTxPopupToastViewPadding];
    NSLayoutConstraint* bgTrailing = [NSLayoutConstraint constraintWithItem:_bgView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-LTxPopupToastViewPadding];
    NSLayoutConstraint* bgTop = [NSLayoutConstraint constraintWithItem:_bgView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.f constant:[LTxPopupToastView getStatusBarHeight]];
    NSLayoutConstraint* bgBottom = [NSLayoutConstraint constraintWithItem:_bgView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.f constant:-LTxPopupToastViewPadding];
    //activate
    [NSLayoutConstraint activateConstraints: @[bgLeading,bgTrailing,bgTop,bgBottom]];
    
    if (_imageView) {//ImageView
        NSLayoutConstraint* imLeading = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_bgView attribute:NSLayoutAttributeLeading multiplier:1.f constant:LTxPopupToastViewPadding];
        NSLayoutConstraint* imWidth = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:LTxPopupToastViewImageWidth];
        NSLayoutConstraint* imTop = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_bgView attribute:NSLayoutAttributeTop multiplier:1.f constant:LTxPopupToastViewPadding];
        NSLayoutConstraint* imHeight = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:LTxPopupToastViewImageWidth];
        //activate
        [NSLayoutConstraint activateConstraints: @[imLeading,imWidth,imTop,imHeight]];
    }
    
    if (_ignoreBtn) {//忽略按钮
        NSLayoutConstraint* igWidth = [NSLayoutConstraint constraintWithItem:_ignoreBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:LTxPopupToastViewButtonWidth];
        NSLayoutConstraint* igTop = [NSLayoutConstraint constraintWithItem:_ignoreBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_bgView attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
        NSLayoutConstraint* igTrailing = [NSLayoutConstraint constraintWithItem:_ignoreBtn attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_bgView attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-LTxPopupToastViewPadding];
        NSLayoutConstraint* igBottom = [NSLayoutConstraint constraintWithItem:_ignoreBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_bgView attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
        //activate
        [NSLayoutConstraint activateConstraints: @[igWidth,igTop,igTrailing,igBottom]];
    }
    
    NSLayoutConstraint* tHeight;
    if (_titleL) {//title Label
        CGFloat leadingConstraint;
        CGFloat traingConstraint;
        if (_imageView) {
            leadingConstraint = LTxPopupToastViewImageWidth + LTxPopupToastViewPadding * 2;
        }else{
            leadingConstraint = LTxPopupToastViewPadding;
        }
        if (_ignoreBtn) {
            traingConstraint = LTxPopupToastViewButtonWidth + LTxPopupToastViewPadding * 2;
        }else{
            traingConstraint = LTxPopupToastViewPadding;
        }
        
        NSLayoutConstraint* tLeading = [NSLayoutConstraint constraintWithItem:_titleL attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_bgView attribute:NSLayoutAttributeLeading multiplier:1.f constant:leadingConstraint];
        NSLayoutConstraint* tTrailing = [NSLayoutConstraint constraintWithItem:_titleL attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_bgView attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-traingConstraint];
        NSLayoutConstraint* tTop = [NSLayoutConstraint constraintWithItem:_titleL attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_bgView attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
        tHeight = [NSLayoutConstraint constraintWithItem:_titleL attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:LTxPopupToastViewTitleHeight];
        //activate
        [NSLayoutConstraint activateConstraints: @[tLeading,tTrailing,tTop,tHeight]];
    }
    
    if (_messageL) {//message Label
        CGFloat leadingConstraint;
        CGFloat topConstraint;
        CGFloat traingConstraint;
        if (_imageView) {
            leadingConstraint = LTxPopupToastViewImageWidth + LTxPopupToastViewPadding * 2;
        }else{
            leadingConstraint = LTxPopupToastViewPadding;
        }
        if (_titleL) {
            topConstraint = LTxPopupToastViewTitleHeight + LTxPopupToastViewPadding * 0.5;
        }else{
            topConstraint = 0;
        }
        
        if (_ignoreBtn) {
            traingConstraint = LTxPopupToastViewButtonWidth + LTxPopupToastViewPadding * 2;
        }else{
            traingConstraint = LTxPopupToastViewPadding;
        }
        
        NSLayoutConstraint* tLeading = [NSLayoutConstraint constraintWithItem:_messageL attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_bgView attribute:NSLayoutAttributeLeading multiplier:1.f constant:leadingConstraint];
        NSLayoutConstraint* tTrailing = [NSLayoutConstraint constraintWithItem:_messageL attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_bgView attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-traingConstraint];
        NSLayoutConstraint* tTop = [NSLayoutConstraint constraintWithItem:_messageL attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_bgView attribute:NSLayoutAttributeTop multiplier:1.f constant:topConstraint];
        NSLayoutConstraint* tBottom = [NSLayoutConstraint constraintWithItem:_messageL attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_bgView attribute:NSLayoutAttributeBottom multiplier:1.f constant:-LTxPopupToastViewPadding];
        //activate
        [NSLayoutConstraint activateConstraints: @[tLeading,tTrailing,tTop,tBottom]];
    }else{
        tHeight.constant = [LTxPopupToastView getNavigationBarHeight] - LTxPopupToastViewPadding;
    }
    
}


#pragma mark - Helper

+(CGFloat)getStatusBarWidth{
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    return CGRectGetWidth(statusBarFrame);
}

+(CGFloat)getStatusBarHeight{
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    return CGRectGetHeight(statusBarFrame);
}
+(CGFloat)getNavigationBarHeight{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 45.f;
    }else if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)){
        return 45.f;
    }else{
        return 33.f;
    }
}

@end




@implementation LTxPopupToastConfiguration
+(instancetype)defaultConfiguration{
    LTxPopupToastConfiguration* config = [[LTxPopupToastConfiguration alloc] init];
    
    // no image
    config.image = nil;
    
    // no ignore btn
    config.showIgnoreBtn = NO;
    config.ignoreBtnTitle = nil;
    config.ignroeBtnTitleColor = nil;
    config.ignoreBtnTitleFontSize = 0.f;
    
    //title color and font
    config.titleColor = [UIColor whiteColor];
    config.titleFontSize = 16.f;
    
    //message color and font
    config.messageColor = [UIColor whiteColor];
    config.messageFontSize = 12.5f;
    
    //animating
    config.showAnimateDuration = 0.6f;
    config.showDuration = 5.f;
    config.autoDismiss = YES;
    
    return config;
}
@end
