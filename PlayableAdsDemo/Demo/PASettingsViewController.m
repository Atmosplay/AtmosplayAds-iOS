//
//  PASettingsViewController.m
//  PlayableAds_Example
//
//  Created by Michael Tang on 2018/9/19.
//  Copyright © 2018年 on99. All rights reserved.
//

#import "PASettingsViewController.h"
#import "PADemoUtils.h"

@interface PASettingsViewController ()

@end

@implementation PASettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)clearCacheAction:(UIBarButtonItem *)sender {
    NSError *error;
    // clear playable cache
    NSURL *directoryURL = [[PADemoUtils shared] baseDirectoryURL];
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryURL.path]) {
        
        [[NSFileManager defaultManager] removeItemAtPath:directoryURL.path error:&error];
    }
    // clear window ad cache
    NSURL *windowAdDirectoryURL = [[PADemoUtils shared] windowAdBaseDirectoryURL];
    if ([[NSFileManager defaultManager] fileExistsAtPath:windowAdDirectoryURL.path]) {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:windowAdDirectoryURL.path error:&error];
    }
    
    if (!error) {
        exit(0);
    }
}

@end
