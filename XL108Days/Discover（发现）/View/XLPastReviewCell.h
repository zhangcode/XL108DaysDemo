//
//  XLPastReviewCell.h
//  XL108Days
//
//  Created by Shelin on 15/12/9.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLPastReviewItem;

@interface XLPastReviewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (nonatomic, strong) XLPastReviewItem *pastReviewItem;

+ (XLPastReviewCell *)pastReviewCellWithCollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath;

@end
