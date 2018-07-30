//
//  LTxPopupAlert.h
//  LTxPopupAlert
//
//  Created by liangtong on 2018/7/30.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import "UIAlertController+LTxPopupAlert.h"

@interface UIViewController (LTxPopupAlert)

/**
 * @brief: Show PopupAlert
 * @param title  Alert title
 * @param message  Alert message
 * @param style Alert type. include UIAlertControllerStyleActionSheet and UIAlertControllerStyleAlert
 * @param sourceView  Alert sourceView. 
 * @param action Alert actions
 **/
-(void)showLTxPopupAlertWithTitle:(NSString*)title message:(NSString*)message style:(UIAlertControllerStyle)style sourceView:(UIView*)sourceView actions:(UIAlertAction*)action,... NS_REQUIRES_NIL_TERMINATION;

@end
