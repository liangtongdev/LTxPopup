//
//  LTxMenuItemTableViewCell.h
//  LTxMenu
//
//  Created by liangtong on 2018/7/26.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LTxCallbackBlock)(void);

@interface LTxMenuItemTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary* item;
@property (nonatomic, copy) LTxCallbackBlock actionCallback;

@property (weak, nonatomic) IBOutlet UIImageView *moreIV;
@end
