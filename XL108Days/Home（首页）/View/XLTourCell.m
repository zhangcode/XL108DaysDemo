//
//  XLTourCell.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/4.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "XLTourCell.h"
#import "XLCellItem.h"

@implementation XLTourCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (XLTourCell *)tourCellWithTableView:(UITableView *)tableview {
    static NSString *ID = @"TourCell";
    XLTourCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"XLTourCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setCellItem:(XLCellItem *)cellItem {
    _cellItem = cellItem;
    
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",IMAGE_HEAD_URL,cellItem.img];
    
    self.imageProgressView.hidden = NO;
    self.imageProgressView.progress = 0.f;
    //监听异步下载图片进度
    
    __weak typeof(self) weakSelf = self;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [weakSelf.imageProgressView setProgress:(CGFloat)receivedSize / expectedSize animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.imageProgressView.hidden = YES;
    }];
    
    self.desLabel.text = cellItem.name;
    
    self.likeCountLabel.text = [cellItem.fav stringValue];
    
    if (cellItem.price) {
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",cellItem.price];
    }else {
        self.priceLabel.text = nil;
    }
}

@end
