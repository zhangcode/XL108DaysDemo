//
//  XLDetailCell.h
//  XL108Days
//
//  Created by Shelin on 15/12/15.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLDetailItem;

@interface XLDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *DetailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *DetailImage;

@property (nonatomic, strong) XLDetailItem *detailItem;

+ (XLDetailCell *)detailCellWithTableView:(UITableView *)tableview;

@end
