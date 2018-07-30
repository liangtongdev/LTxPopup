//
//  UIViewController+LTxPopupMenu.m
//  LTxPopupMenu
//
//  Created by liangtong on 2018/7/26.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import "LTxPopupMenu.h"

/**************************************************************/
/************************LTxPopupMenuController****************/
/**************************************************************/
#define LTxPopupMenuTableViewCellIdentifier @"LTxPopupMenuTableViewCellIdentifier"
@interface LTxPopupMenuController:UITableViewController
@property (nonatomic, weak) id<LTxPopupMenuDelegate> menuDelegate;
@property (nonatomic, assign) BOOL customNibCell;
@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@end;

@implementation LTxPopupMenuController
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - TableViewDataSource && TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.menuDelegate) {
        return [self.menuDelegate ltx_numberOfRows];
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LTxPopupMenuTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:self.cellStyle reuseIdentifier:LTxPopupMenuTableViewCellIdentifier];
    }
    
    if (self.menuDelegate) {
        [self.menuDelegate ltx_configMenuCellItem:cell forIndex:indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if ([self.menuDelegate respondsToSelector:@selector(ltx_selectedIndex:)]) {
        [self.menuDelegate ltx_selectedIndex:indexPath.row];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

/**************************************************************/
/*********************LTxPopupMenuConfiguration****************/
/**************************************************************/
@implementation LTxPopupMenuConfiguration

+(instancetype)defaultConfiguration{
    LTxPopupMenuConfiguration* _instance = [[LTxPopupMenuConfiguration alloc] init];
    _instance.arrowColor = [UIColor whiteColor];
    _instance.arrowDirection = UIPopoverArrowDirectionAny;
    _instance.menuContentSize = CGSizeMake(200, 300);
    
    _instance.rowHeight = 50.f;
    _instance.estimatedRowHeight = 50.f;
    _instance.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _instance.separatorColor = [UIColor lightGrayColor];
    _instance.itemStyle = UITableViewCellStyleDefault;
    _instance.showsScrollIndicator = NO;
    
    return _instance;
}
@end

/**
 * 私有类，为了实现协议：UIPopoverPresentationControllerDelegate
 **/
@interface UIViewController (LTxPopupMenuPopover)<UIPopoverPresentationControllerDelegate>
@end

/**************************************************************/
/**************************LTxPopupMenu************************/
/**************************************************************/
@implementation UIViewController (LTxPopupMenu)

-(void)showLTxPopupMenuFrom:(UIView*)fromView
         configuration:(LTxPopupMenuConfiguration*)configuration
              delegate:(id<LTxPopupMenuDelegate>)delegate{
    LTxPopupMenuController* popover = [[LTxPopupMenuController alloc] init];
    popover.modalPresentationStyle = UIModalPresentationPopover;
    //config sourceView
    popover.popoverPresentationController.sourceView = fromView;
    popover.popoverPresentationController.sourceRect = fromView.bounds;
    //arrow color
    UIColor* arrowColor = configuration.arrowColor?:[UIColor whiteColor];
    popover.popoverPresentationController.backgroundColor = arrowColor;
    //arrow direction
    UIPopoverArrowDirection direction = configuration.arrowDirection;
    popover.popoverPresentationController.permittedArrowDirections = direction;
    //content size
    CGSize contentSize = configuration.menuContentSize;
    if (CGSizeEqualToSize(contentSize, CGSizeZero)) {
        contentSize = CGSizeMake(200, 300);
    }
    popover.preferredContentSize = contentSize;
    
    //config tableview
    popover.tableView.rowHeight = configuration.rowHeight;
    popover.tableView.estimatedRowHeight = configuration.estimatedRowHeight;
    popover.tableView.separatorStyle = configuration.separatorStyle;
    if (configuration.separatorStyle != UITableViewCellSeparatorStyleNone) {
        popover.tableView.separatorColor = configuration.separatorColor?:[UIColor lightGrayColor];
    }
    popover.tableView.showsVerticalScrollIndicator = configuration.showsScrollIndicator;
    if (configuration.cellNib) {
        [popover.tableView registerNib:configuration.cellNib forCellReuseIdentifier:LTxPopupMenuTableViewCellIdentifier];
        popover.customNibCell = true;
    }
    
    //delegate
    popover.popoverPresentationController.delegate = self;
    popover.menuDelegate = delegate;
    
    [self presentViewController:popover animated:NO completion:^{
        
    }];
}


/**
 * private to adjust UIPopoverPresentationControllerDelegate
 **/
#pragma mark - UIPopoverPresentationControllerDelegate
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}
- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    
}

@end
