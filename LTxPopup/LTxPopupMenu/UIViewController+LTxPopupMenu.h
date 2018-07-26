//
//  UIViewController+LTxPopupMenu.h
//  LTxPopupMenu
//
//  Created by liangtong on 2018/7/26.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * Configuration for LTxPopupMenu
 **/
@interface LTxPopupMenuConfiguration : NSObject

//arrow color. default is [UIColor whiteColor]
@property (nonatomic, strong) UIColor* arrowColor;

//arrow direction. default is UIPopoverArrowDirectionAny
@property (nonatomic, assign) UIPopoverArrowDirection arrowDirection;

//menu content size. default is CGSizeMake(200, 300)
@property (nonatomic, assign) CGSize menuContentSize;

/**
 * menu item height. default is 50.f
 * you should set it to UITableViewAutomaticDimension when estimoting row height
 **/
@property (nonatomic, assign) CGFloat rowHeight;
/**
 * estimoted item height. default is 50.f
 **/
@property (nonatomic, assign) CGFloat estimatedRowHeight;
/**
 * menu item separator style. default is line
 **/
@property (nonatomic, assign) UITableViewCellSeparatorStyle separatorStyle;
/**
 * menu item separator line color. default is [UIColor lightGrayColor]
 **/
@property (nonatomic, strong) UIColor* separatorColor;
/**
 * menu item cell style. default is UITableViewCellStyleDefault
 **/
@property (nonatomic, assign) UITableViewCellStyle itemStyle;
/**
 * menu scroll indicator. default value is NO.
 **/
@property (nonatomic, assign) BOOL showsScrollIndicator;
/**
 * when you want to use nib with LTxPopupMenu item.
 **/
@property (nonatomic, strong) UINib* cellNib;

/**
 * @brief: init method. also you can use alloc and init method.
 **/
+(instancetype)defaultConfiguration;

@end

//protocol
@protocol LTxPopupMenuDelegate;

/**
 * LTxPopupMenu
 **/
@interface UIViewController (LTxPopupMenu)

/**
 * @brief: show popupMenu
 * @param fromView  you can just think of it is the arrow position
 * @param configuration  the configuration of LTxPopupMenu
 * @param delegate delegate
 **/
-(void)showLTxPopupMenuFrom:(UIView*)fromView
              configuration:(LTxPopupMenuConfiguration*)configuration
                   delegate:(id<LTxPopupMenuDelegate>)delegate;

@end

/**
 * delegate
 **/
@protocol LTxPopupMenuDelegate <NSObject>

@required
/**
 * number of rows in popupMenu
 **/
-(NSInteger)ltx_numberOfRows;

/**
 * custom menu item at index
 **/
-(void)ltx_configMenuCellItem:(UITableViewCell*)cell forIndex:(NSInteger)index;


@optional
/**
 * menu item is selected at index
 **/
-(void)ltx_selectedIndex:(NSInteger)index;

@end
