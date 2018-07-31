//
//  LTxPopupToast.m
//  LTxPopupToast
//
//  Created by liangtong on 2018/7/30.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import "LTxPopupToast.h"


@interface LTxPopupToast()
@property (nonatomic, strong) NSMutableArray* ltxPopupToastQueue;
@end

@implementation LTxPopupToast

+(void)showLTxPopupToastWithConfiguration:(LTxPopupToastConfiguration*)configuration
                                     show:(LTxPopupCallback)showCallback
                                      tap:(LTxPopupCallback)tapCallback
                                  dismiss:(LTxPopupCallback)dismissCallback{
    LTxPopupToastView* toastView = [LTxPopupToastView instanceWithConfiguration:configuration];
    toastView.showCallback = showCallback;
    toastView.tapCallback = tapCallback;
    toastView.dismissCallback = dismissCallback;
    
}
@end
