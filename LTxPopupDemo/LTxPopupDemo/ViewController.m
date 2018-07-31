//
//  ViewController.m
//  LTxPopupMenu
//
//  Created by liangtong on 2018/7/26.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import "ViewController.h"
#import "LTxPopup.h"
#import "LTxMenuItemTableViewCell.h"

@interface ViewController ()<LTxPopupMenuDelegate>
@property (nonatomic, strong) NSArray* dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    _dataSource = @[
                    @{
                        @"avatar":@"avatar1",
                        @"name":@"liangtongdev",
                        @"text":@"Load from Nib file "
                        },
                    @{
                        @"avatar":@"avatar2",
                        @"name":@"LTxPopupMenu",
                        @"text":@"Do any additional setup after loading the view "
                        },
                    @{
                        @"avatar":@"avatar3",
                        @"name":@"LTxPopupMenu",
                        @"text":@"Created by liangtong on 2018/7/26 "
                        },
                    @{
                        @"avatar":@"avatar4",
                        @"name":@"LTxPopupMenu",
                        @"text":@"Copyright © 2018年 LTx. All rights reserved"
                        },
                    
                    ];
}

- (IBAction)showPopupView:(UIButton *)sender {
    LTxPopupViewConfiguration* config = [LTxPopupViewConfiguration defaultConfiguration];
    config.containerBackgroundColor = [[UIColor brownColor] colorWithAlphaComponent:0.2];
    config.cornerSize = 25.f;
    config.dismissOnTapOutside = NO;
    config.showAnimationType = LTxPopupShowAnimationFromTop;
    config.showAnimationDuration = .6f;
    config.hideAnimationType = LTxPopupHideAnimationFadeOut;
    config.hideAnimationDuration = .4f;
    
    
    UIView* popView = [[UIView alloc] initWithFrame:CGRectMake(30, 160, 220, 200)];
    popView.backgroundColor = [UIColor redColor];
    
    [self showLTxPopupView:popView configuration:config];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideLTxPopupView];
    });
}


- (IBAction)showPopupViewFromView:(UIButton *)sender {
    
    LTxPopupViewConfiguration* config = [LTxPopupViewConfiguration defaultConfiguration];
    config.containerBackgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.1];
    config.cornerSize = 25.f;
    config.dismissOnTapOutside = YES;
    config.showAnimationType = LTxPopupShowAnimationFromBottom;
    config.showAnimationDuration = .6f;
    
    
    UIView* popView = [[UIView alloc] initWithFrame:CGRectMake(230, 360, 120, 200)];
    popView.backgroundColor = [UIColor blueColor];
    
    [self.view showLTxPopupView:popView configuration:config];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view hideLTxPopupView];
    });
    
}


- (IBAction)showMenu:(UIButton *)sender {
    LTxPopupMenuConfiguration* config = [LTxPopupMenuConfiguration defaultConfiguration];
    if (sender.tag == 1) {
        config.arrowDirection = UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown;
    }else if (sender.tag == 2) {
        config.separatorStyle = UITableViewCellSeparatorStyleNone;
        config.arrowDirection = UIPopoverArrowDirectionLeft;
        config.menuContentSize = CGSizeMake(240, 200);
    }else{
        config.separatorStyle = UITableViewCellSeparatorStyleNone;
        config.arrowDirection = UIPopoverArrowDirectionDown;
        config.menuContentSize = CGSizeMake(220, 200);
    }
    [self showLTxPopupMenuFrom:sender configuration:config delegate:self];
}

- (IBAction)showCustomNibMenu:(UIButton *)sender {
    LTxPopupMenuConfiguration* config = [LTxPopupMenuConfiguration defaultConfiguration];
    config.rowHeight = UITableViewAutomaticDimension;
    config.menuContentSize = CGSizeMake(360, 200);
    config.separatorStyle = UITableViewCellSeparatorStyleNone;
    config.cellNib = [UINib nibWithNibName:@"LTxMenuItemTableViewCell" bundle:nil];
    [self showLTxPopupMenuFrom:sender configuration:config delegate:self];
}
- (IBAction)showAlertControllerView:(UIButton *)sender {
    
    UIAlertControllerStyle style = rand() % 2 == 1 ? UIAlertControllerStyleActionSheet : UIAlertControllerStyleAlert;
    
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"%s",__func__);
    }];
    UIAlertAction* desAction = [UIAlertAction actionWithTitle:@"撤销"
                                                        style:UIAlertActionStyleDestructive
                                                      handler:nil];
    [self showLTxPopupAlertWithTitle:@"提醒"
                             message:@"这是一个AlertViewController"
                               style:style
                          sourceView:nil
                             actions:cancelAction,okAction,desAction,nil];
}
- (IBAction)showToast:(UIButton *)sender {
    
    LTxPopupToastConfiguration* configuration = [LTxPopupToastConfiguration defaultConfiguration];
//    configuration.image = [UIImage imageNamed:@"teal_checkmark"];
//    configuration.title = @"Notification";
    configuration.message = @"This liangtong from zhengzhou. thanks very much.   😄 ";
    configuration.messageColor = [UIColor yellowColor];
    configuration.messageFontSize = 15.f;
    
    [LTxPopupToast showLTxPopupToastWithConfiguration:configuration show:^{
        NSLog(@"popup toast show complete");
    } tap:^{
        NSLog(@"tap at popup toast ");
    } dismiss:^{
        NSLog(@"popup toast dismissed");
    }];
}



-(NSInteger)ltx_numberOfRows{
    return _dataSource.count;
}
-(void)ltx_configMenuCellItem:(UITableViewCell*)cell forIndex:(NSInteger)index{
    NSDictionary* item = [_dataSource objectAtIndex:index];
    if ([cell isKindOfClass:[LTxMenuItemTableViewCell class]]) {
        LTxMenuItemTableViewCell* nibCell = (LTxMenuItemTableViewCell*)cell;
        nibCell.item = item;
        return;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第 %td 行",index + 1];
    if (index % 2 == 0) {
        cell.imageView.image = [UIImage imageNamed:[item objectForKey:@"avatar"]];
        cell.contentView.backgroundColor = [UIColor colorWithRed:59/255.0 green:145/255.0 blue:233/255.0 alpha:0.4];
    }else{
        cell.imageView.image = [UIImage imageNamed:[item objectForKey:@"avatar"]];
        cell.textLabel.textColor = [UIColor blueColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
}

-(void)ltx_selectedIndex:(NSInteger)index{
    
}

@end
