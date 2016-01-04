//
//  XLTourCell.h
//  XL108Days
//
//  Created by Shelin on 15/12/4.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLCellItem;

@interface XLTourCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIProgressView *imageProgressView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (nonatomic, strong) XLCellItem *cellItem;

+ (XLTourCell *)tourCellWithTableView:(UITableView *)tableview ;
@end
