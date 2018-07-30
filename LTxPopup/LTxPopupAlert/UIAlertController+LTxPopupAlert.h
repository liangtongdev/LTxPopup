//
//  UIAlertController+LTxPopupAlert.h
//  LTxPopupAlert
//
//  Created by liangtong on 2018/7/30.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (LTxPopupAlert)

/**
 * @brief: Return An UIAlertViewController. User can Custom actions and alert field.
 **/
+(UIAlertController*)ltxAlertControllerWithTitle:(NSString*)title message:(NSString*)message style:(UIAlertControllerStyle)style sourceView:(UIView*)sourceView;

/**
 * Add Alert Actions
 **/
-(void)ltxAddPopupActions:(UIAlertAction*)action,... NS_REQUIRES_NIL_TERMINATION;


@end
