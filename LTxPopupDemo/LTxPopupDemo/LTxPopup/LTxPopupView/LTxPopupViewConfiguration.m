//
//  LTxPopupViewConfiguration.m
//  LTxPopupView
//
//  Created by liangtong on 2018/7/27.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import "LTxPopupViewConfiguration.h"

@implementation LTxPopupViewConfiguration

+(instancetype)defaultConfiguration{
    LTxPopupViewConfiguration* config = [[LTxPopupViewConfiguration alloc] init];
    

    config.containerBackgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    config.dismissOnTapOutside = NO;
    
    config.cornerSize = 10.f;
    
    config.showAnimationType = LTxPopupShowAnimationAppear;
    config.hideAnimationType = LTxPopupHideAnimationDisappear;
    config.showAnimationDuration = 0.4f;
    config.hideAnimationDuration = 0.f;
    return config;
}
@end
