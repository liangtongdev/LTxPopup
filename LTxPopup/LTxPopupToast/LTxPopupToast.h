//
//  LTxPopupToast.h
//  LTxPopupToast
//
//  Created by liangtong on 2018/7/30.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTxPopupToastView.h"
/**
 * Toast
 ***/

@interface LTxPopupToast : NSObject

/**
 * @brief: show toast
 * @param configuration  configuration about toast background color. title message and so on.
 * @param showCallback  callback when show completed.
 * @param tapCallback  callback when taped.
 * @param dismissCallback  callback when dismiss.
 **/
+(void)showLTxPopupToastWithConfiguration:(LTxPopupToastConfiguration*)configuration
                                     show:(LTxPopupCallback)showCallback
                                      tap:(LTxPopupCallback)tapCallback
                                  dismiss:(LTxPopupCallback)dismissCallback;


@end
