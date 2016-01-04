//
//  XLDetailCell.m
//  XL108Days
//
//  Created by Shelin on 15/12/15.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "XLDetailCell.h"
#import "XLDetailItem.h"

@implementation XLDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (XLDetailCell *)detailCellWithTableView:(UITableView *)tableview {
    static NSString *ID = @"DetailCell";
    XLDetailCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"XLDetailCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setDetailItem:(XLDetailItem *)detailItem {
    
    _detailItem = detailItem;
    NSRange range = [detailItem.detailStr rangeOfString:@"http"];

    if (range.length) {
       self.DetailLabel.hidden = YES;
        self.DetailImage.hidden = NO;
        [self.DetailImage sd_setImageWithURL:[NSURL URLWithString:detailItem.detailStr]];
    }else {
        self.DetailLabel.hidden = NO;
        self.DetailImage.hidden = YES;
        self.DetailLabel.text = detailItem.detailStr;
    }
}

@end
