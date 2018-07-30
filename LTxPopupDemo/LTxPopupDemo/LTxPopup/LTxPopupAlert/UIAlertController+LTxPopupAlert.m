//
//  UIAlertController+LTxPopupAlert.m
//  LTxPopupAlert
//
//  Created by liangtong on 2018/7/30.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import "UIAlertController+LTxPopupAlert.h"

@implementation UIAlertController (LTxPopupAlert)


+(UIAlertController*)ltxAlertControllerWithTitle:(NSString*)title message:(NSString*)message style:(UIAlertControllerStyle)style sourceView:(UIView*)sourceView{
    //init
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    //iPad popover
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover) {
        if(sourceView){
            popover.sourceView = sourceView;
            popover.sourceRect = sourceView.frame;
        }else{
            UIViewController* sourceController = [UIApplication sharedApplication].keyWindow.rootViewController;
            UIView* sourceView = sourceController.view;
            CGPoint center = sourceView.center;
            CGRect frame = CGRectMake(center.x - 50, center.y - 50, 100, 100);
            
            popover.sourceView = sourceView;
            popover.sourceRect = frame;
        }
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    
    return alertController;
}

/**
 * Add Alert Actions
 **/
-(void)ltxAddPopupActions:(UIAlertAction*)action,... NS_REQUIRES_NIL_TERMINATION{
    //Add actions
    if(action){
        [self addAction:action];
        va_list list;//指向变参的指针
        va_start(list, action);//使用第一个参数来初使化list指针
        while (true) {
            UIAlertAction* otherAction = va_arg(list, UIAlertAction*);//后续参数遍历
            if (!otherAction) {
                break;
            }
            [self addAction:otherAction];
        }
        va_end(list);// 清空参数列表，并置参数指针args无效
    }
}
@end
