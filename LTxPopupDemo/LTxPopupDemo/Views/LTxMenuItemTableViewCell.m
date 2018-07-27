//
//  LTxMenuItemTableViewCell.m
//  LTxMenu
//
//  Created by liangtong on 2018/7/26.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import "LTxMenuItemTableViewCell.h"
@interface LTxMenuItemTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *textL;
@end

@implementation LTxMenuItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 2.f;
    self.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.bgView.layer.shadowOpacity = 0.6;
    self.bgView.layer.shadowOffset = CGSizeMake(3, 3);
    self.bgView.layer.shadowRadius = 3.0;
    
    self.iconIV.layer.borderColor = [UIColor brownColor].CGColor;
    self.iconIV.layer.cornerRadius = 15.f;
    self.iconIV.layer.borderWidth = 1.f;
    self.iconIV.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setItem:(NSDictionary *)item{
    NSString* icon = [item objectForKey:@"avatar"];
    NSString* name = [item objectForKey:@"name"];
    NSString* text = [item objectForKey:@"text"];
    self.iconIV.image = [UIImage imageNamed:icon];
    self.nameL.text = name;
    self.textL.text = text;
}

@end
