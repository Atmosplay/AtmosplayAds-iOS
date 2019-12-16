//
//  PANativeAdTableViewCell.h
//  PlayableAds_Example
//
//  Created by Michael Tang on 2018/9/17.
//  Copyright © 2018年 on99. All rights reserved.
//

#import <AtmosplayAds/AtmosplayNativeAdModel.h>
#import <UIKit/UIKit.h>

@interface PANativeAdTableViewCell : UITableViewCell

- (void)setCellNativeData:(AtmosplayNativeAdModel *)nativeAd;
- (void)mediaPlay;
- (void)mediaPause;

@end
