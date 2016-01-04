//
//  XLPastReviewCell.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/9.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "XLPastReviewCell.h"
#import "XLPastReviewItem.h"

@implementation XLPastReviewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (XLPastReviewCell *)pastReviewCellWithCollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath {
    UINib *nib = [UINib nibWithNibName:@"XLPastReviewCell" bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"PastReviewCell"];
    XLPastReviewCell *cell = [[XLPastReviewCell alloc]init];
    cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"PastReviewCell" forIndexPath:indexPath];
    return cell;
}

- (void)setPastReviewItem:(XLPastReviewItem *)pastReviewItem {
    
    _pastReviewItem = pastReviewItem;
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",IMAGE_HEAD_URL,pastReviewItem.img];
    self.progressView.hidden = NO;
    self.progressView.progress = 0.f;
    //监听异步下载图片进度
    __weak typeof(self) weakSelf = self;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = (CGFloat)receivedSize / (CGFloat)expectedSize;
        [weakSelf.progressView setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.progressView.hidden = YES;
    }];
    self.desLabel.text = pastReviewItem.name;
}

@end
