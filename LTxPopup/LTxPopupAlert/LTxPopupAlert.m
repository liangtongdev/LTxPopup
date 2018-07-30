//
//  LTxPopupAlert.m
//  LTxPopupAlert
//
//  Created by liangtong on 2018/7/30.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import "LTxPopupAlert.h"

@implementation UIViewController (LTxPopupAlert)

/**
 * @brief: Show PopupAlert
 * @param title  Alert title
 * @param message  Alert message
 * @param style Alert type. include UIAlertControllerStyleActionSheet and UIAlertControllerStyleAlert
 * @param sourceView  Alert sourceView. When showed on iPad
 * @param action Alert actions
 **/
-(void)showLTxPopupAlertWithTitle:(NSString*)title message:(NSString*)message style:(UIAlertControllerStyle)style sourceView:(UIView*)sourceView actions:(UIAlertAction*)action,... NS_REQUIRES_NIL_TERMINATION{
    
    //init alertController
    UIAlertController *alertController = [UIAlertController ltxAlertControllerWithTitle:title message:message style:style sourceView:sourceView];
    
    //Add actions
    if(action){
        [alertController addAction:action];
        va_list list;//指向变参的指针
        va_start(list, action);//使用第一个参数来初使化list指针
        while (true) {
            UIAlertAction* otherAction = va_arg(list, UIAlertAction*);//后续参数遍历
            if (!otherAction) {
                break;
            }
            [alertController addAction:otherAction];
        }
        va_end(list);// 清空参数列表，并置参数指针args无效
    }
    
    //Show
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

@end
