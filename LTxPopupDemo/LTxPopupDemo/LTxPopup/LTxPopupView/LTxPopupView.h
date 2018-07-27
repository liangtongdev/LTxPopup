//
//  UIViewController+LTxPopupView.h
//  LTxPopupView
//
//  Created by liangtong on 2018/7/27.
//  Copyright © 2018年 LTx. All rights reserved.
//


#import "LTxPopupViewConfiguration.h"

@interface UIViewController (LTxPopupView)
/**
 * @brief: show popupView
 * @param popView popupView
 * @param configuration  the configuration of LTxPopupView
 **/
-(void)showLTxPopupView:(UIView*)popView configuration:(LTxPopupViewConfiguration*)configuration;

/**
 * @brief: hide popupView
 **/
-(void)hideLTxPopupView;
@end



@interface UIView (LTxPopupView)
/**
 * @brief: show popupView
 * @param popView popupView
 * @param configuration  the configuration of LTxPopupView
 **/
-(void)showLTxPopupView:(UIView*)popView configuration:(LTxPopupViewConfiguration*)configuration;

/**
 * @brief: hide popupView
 **/
-(void)hideLTxPopupView;
@end
