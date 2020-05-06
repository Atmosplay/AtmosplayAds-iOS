//
//  PAMenuViewController.m
//  PlayableAds_Example
//
//  Created by Michael Tang on 2018/9/19.
//  Copyright © 2018年 on99. All rights reserved.
//

#import "PAMenuViewController.h"
#import "PAPlayableAdsViewController.h"
#import "PADemoUtils.h"
#import "AtmosplayFloatAdViewController.h"
#import "AtmosplayWindowAdViewController.h"

@interface PAMenuViewController () <UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *adList;
@property (nonatomic) AtmosplayFloatAdViewController *floatAdVc;
@property (nonatomic) AtmosplayWindowAdViewController *windowAdVc;

@end

@implementation PAMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Select one of the options below".uppercaseString;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"VideoId"]) {
        PAPlayableAdsViewController *playableVc = segue.destinationViewController;
        playableVc.isVideo = YES;

    } else if ([segue.identifier isEqualToString:@"InterstitialId"]) {
        PAPlayableAdsViewController *playableVc = segue.destinationViewController;
        playableVc.isVideo = NO;
    }
}

#pragma mark - uitableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 6) {
        self.floatAdVc = [[AtmosplayFloatAdViewController alloc] init];
        self.floatAdVc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:self.floatAdVc animated:NO completion:nil];
    }
    if (indexPath.row == 7) {
        self.windowAdVc = [[AtmosplayWindowAdViewController alloc] init];
        self.windowAdVc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:self.windowAdVc animated:NO completion:nil];
    }
}

@end
