//
//  TestPopupMenuTableViewController.m
//  LTxPopupDemo
//
//  Created by liangtong on 2018/8/30.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import "TestPopupMenuTableViewController.h"
#import "LTxMenuItemTableViewCell.h"
#import "LTxPopup.h"

#define  LTxMenuItemTableViewCellIdentifier @"LTxMenuItemTableViewCellIdentifier"
@interface TestPopupMenuTableViewController ()<LTxPopupMenuDelegate>

@property (nonatomic, strong) UIButton* addBtn;
@property (nonatomic, strong) NSArray* menuList;
@property (nonatomic, strong) NSArray* menuList1;
@property (nonatomic, strong) NSArray* menuList2;
@property (nonatomic, strong) NSArray* dataSource;

@end

@implementation TestPopupMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPopupMenuTableViewUI];
}

#pragma mark - UI
-(void)setupPopupMenuTableViewUI{
    self.navigationItem.title = @"弹出菜单";
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [_addBtn addTarget:self action:@selector(showMenuList:) forControlEvents:UIControlEventTouchUpInside];
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_addBtn];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LTxMenuItemTableViewCell" bundle:nil] forCellReuseIdentifier:LTxMenuItemTableViewCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 140.f;
}

#pragma mark - Action
-(void)showMenuList:(UIButton*)sender{
    
    self.menuList = self.menuList1;
    
    LTxPopupMenuConfiguration* config = [LTxPopupMenuConfiguration defaultConfiguration];
    config.arrowDirection = UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown;
    config.menuContentSize = CGSizeMake(160, 300);
    [self showLTxPopupMenuFrom:sender configuration:config delegate:self];
}

#pragma mark - LTxPopupMenuDelegate
-(NSInteger)ltx_numberOfRows{
    return self.menuList.count;
}
-(void)ltx_configMenuCellItem:(UITableViewCell*)cell forIndex:(NSInteger)index{
    //使用nib或者自定义cell时候，进行配置
    NSDictionary* item = [_menuList objectAtIndex:index];
    cell.textLabel.text = [item objectForKey:@"title"];
    cell.imageView.image = [UIImage imageNamed:[item objectForKey:@"image"]];
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[item objectForKey:@"more"]]];
}

-(void)ltx_selectedIndex:(NSInteger)index{
    
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LTxMenuItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LTxMenuItemTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[LTxMenuItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LTxMenuItemTableViewCellIdentifier];
    }
    cell.item = [_dataSource objectAtIndex:indexPath.row];
    cell.actionCallback = ^{
        
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LTxMenuItemTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    self.menuList = self.menuList2;
    
    LTxPopupMenuConfiguration* config = [LTxPopupMenuConfiguration defaultConfiguration];
    config.arrowDirection = UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown;
    config.menuContentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 200);
    [self showLTxPopupMenuFrom:cell.moreIV configuration:config delegate:self];
}

#pragma mark - Getter

-(NSArray*)dataSource{
    if(!_dataSource){
        _dataSource = @[
                        @{
                            @"avatar":@"1",
                            @"name":@"微视频丨保护好眼睛 才能看到爱",
                            @"text":@"不知从何时起，每天睁开眼,我们就淹没在各式“屏幕”之中，还特别不耐烦爸妈没完没了的唠叨。"
                            },
                        @{
                            @"avatar":@"2",
                            @"name":@"这件事，让习近平揪心",
                            @"text":@"我国青少年近视率排名世界第一，让人忧虑。近日，习近平总书记就青少年视力健康问题连续作出重要指示 "
                            },
                        @{
                            @"avatar":@"3",
                            @"name":@"《中非合作新时代》第三集《利益相融》",
                            @"text":@"央视网消息：由中央广播电视总台所属中国国际电视台制作的五集专题片《中非合作新时代》（每集30分钟），正式在央视一套播出 "
                            },
                        @{
                            @"avatar":@"4",
                            @"name":@"着力体现新时代新使命新要求",
                            @"text":@"中国特色社会主义进入了新时代，这是我国发展新的历史方位。新时代要有新气象，更要有新作为"
                            },
                        @{
                            @"avatar":@"5",
                            @"name":@"滴滴5天被10余城约谈责令整改",
                            @"text":@"在乐清女孩乘顺风车被杀后的第4天，滴滴28日再次道歉，这次出面的是滴滴创始人兼CEO程维和滴滴总裁柳青，但民愤并没有平息。面对滴滴存在的问题，各地相继出手"
                            },
                        @{
                            @"avatar":@"6",
                            @"name":@"台湾作家阿富汗旅游被要求到北京办签证",
                            @"text":@"据台媒报道，台湾知名小说家李昂日前参加阿富汗旅游行程，在进入阿富汗时，被要求到北京领签证，因为“台湾是中国的一部分”。"
                            },
                        @{
                            @"avatar":@"7",
                            @"name":@"天安门前花式遮阳的游客",
                            @"text":@"8月30日报道，8月29日，北京天安门广场游客花式遮阳各有妙招。当天北京晴热曝晒依旧，午后紫外线照射强烈，热力十足。"
                            }
                        ];
    }
    return _dataSource;
}

-(NSArray*)menuList1{
    if(!_menuList1){
        _menuList1 = @[
                      @{
                          @"image":@"menuList1-1",
                          @"title":@"创建群聊"
                          },
                      @{
                          @"image":@"menuList1-2",
                          @"title":@"加好友/群"
                          },
                      @{
                          @"image":@"menuList1-3",
                          @"title":@"扫一扫"
                          },
                      @{
                          @"image":@"menuList1-4",
                          @"title":@"面对面快传"
                          },
                      @{
                          @"image":@"menuList1-5",
                          @"title":@"收付款"
                          },
                      @{
                          @"image":@"menuList1-6",
                          @"title":@"高能舞室"
                          },
                      ];
    }
    return _menuList1;
}

-(NSArray*)menuList2{
    if(!_menuList2){
        _menuList2 = @[
                       @{
                           @"image":@"ic_more_share",
                           @"title":@"分享",
                           @"more":@"ic_more_share_wechat"
                           },
                       @{
                           @"image":@"ic_more_favor",
                           @"title":@"收藏"
                           },
                       @{
                           @"image":@"ic_more_report",
                           @"title":@"举报"
                           },
                       @{
                           @"image":@"ic_more_reprint",
                           @"title":@"转载"
                           }
                       ];
    }
    return _menuList2;
}

@end
