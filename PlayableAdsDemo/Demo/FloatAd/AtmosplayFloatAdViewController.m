//
//  AtmosplayFloatAdViewController.m
//  PlayableAds_Example
//
//  Created by jdy on 2020/3/22.
//  Copyright © 2020 AtmosplayAds. All rights reserved.
//

#import "AtmosplayFloatAdViewController.h"
#import <Masonry/Masonry.h>
#import <AtmosplayAds/PAUtils.h>
#import <AtmosplayAds/AtmosplayFloatAd.h>

@interface AtmosplayFloatAdViewController () <AtmosplayFloatAdDelegate>
@property (nonatomic) UITextField *appID;
@property (nonatomic) UITextField *adUnitID;
@property (nonatomic) UITextField *xTextField;
@property (nonatomic) UITextField *yTextField;
@property (nonatomic) UITextField *widthTextField;
@property (nonatomic) UIButton *requestButton;
@property (nonatomic) UIButton *showButton;
@property (nonatomic) UIButton *destroyButton;
@property (nonatomic) UIButton *loadModeButton;
@property (nonatomic) UIButton *hiddenFloatAdButton;
@property (nonatomic) UIButton *showAgainAfterHidingButton;
@property (nonatomic) UIButton *dismissVcButton;
@property (nonatomic) UIButton *resetFrameButton;
@property (nonatomic) UITextView *console;

@property (nonatomic) AtmosplayFloatAd *floatAd;
@property (nonatomic, assign) BOOL isAutoLoad;

@end

@implementation AtmosplayFloatAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)setUpUI {
    PAUtils *tool = [PAUtils sharedUtils];
    CGFloat marginTop = (tool.iSiPhoneX || tool.iSiPhoneXR) ? 100.0 : 80.0;
    CGFloat margin = 15.0;
    CGFloat height = [tool adaptedValue6:40];

    self.appID = [[UITextField alloc] init];
    self.appID.borderStyle = UITextBorderStyleRoundedRect;
    self.appID.backgroundColor = [UIColor blackColor];
    self.appID.placeholder = @"Please Input Your App ID";
    self.appID.textColor = [UIColor whiteColor];
    [self.appID setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.appID.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.appID.autocapitalizationType = UITextAutocapitalizationTypeNone;

    self.adUnitID = [[UITextField alloc] init];
    self.adUnitID.borderStyle = UITextBorderStyleRoundedRect;
    self.adUnitID.backgroundColor = [UIColor blackColor];
    self.adUnitID.placeholder = @"Please Input Your Unit ID";
    self.adUnitID.textColor = [UIColor whiteColor];
    [self.adUnitID setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.adUnitID.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.adUnitID.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    self.xTextField = [[UITextField alloc] init];
    self.xTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.xTextField.backgroundColor = [UIColor blackColor];
    self.xTextField.placeholder = @"x";
    self.xTextField.textColor = [UIColor whiteColor];
    [self.xTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.xTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.xTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    self.yTextField = [[UITextField alloc] init];
    self.yTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.yTextField.backgroundColor = [UIColor blackColor];
    self.yTextField.placeholder = @"y";
    self.yTextField.textColor = [UIColor whiteColor];
    [self.yTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.yTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.yTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    self.widthTextField = [[UITextField alloc] init];
    self.widthTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.widthTextField.backgroundColor = [UIColor blackColor];
    self.widthTextField.placeholder = @"width";
    self.widthTextField.textColor = [UIColor whiteColor];
    [self.widthTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.widthTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.widthTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;

    self.requestButton = [[UIButton alloc] init];
    self.requestButton.backgroundColor = [UIColor blackColor];
    [self.requestButton setTitle:@"Request" forState:UIControlStateNormal];
    [self.requestButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    self.requestButton.layer.cornerRadius = 5;
    self.requestButton.layer.masksToBounds = YES;
    [self.requestButton addTarget:self action:@selector(requestFloatAd) forControlEvents:UIControlEventTouchUpInside];

    self.showButton = [[UIButton alloc] init];
    self.showButton.backgroundColor = [UIColor blackColor];
    [self.showButton setTitle:@"Show" forState:UIControlStateNormal];
    [self.showButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    self.showButton.layer.cornerRadius = 5;
    self.showButton.layer.masksToBounds = YES;
    [self.showButton addTarget:self action:@selector(showFloatAd) forControlEvents:UIControlEventTouchUpInside];

    self.destroyButton = [[UIButton alloc] init];
    self.destroyButton.backgroundColor = [UIColor blackColor];
    [self.destroyButton setTitle:@"Destroy" forState:UIControlStateNormal];
    [self.destroyButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    self.destroyButton.layer.cornerRadius = 5;
    self.destroyButton.layer.masksToBounds = YES;
    [self.destroyButton addTarget:self action:@selector(destroyFloatAd) forControlEvents:UIControlEventTouchUpInside];
    
    self.loadModeButton = [[UIButton alloc] init];
    self.loadModeButton.backgroundColor = [UIColor blackColor];
    [self.loadModeButton setTitle:@"Enable Auto Load" forState:UIControlStateNormal];
    [self.loadModeButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    self.loadModeButton.layer.cornerRadius = 5;
    self.loadModeButton.layer.masksToBounds = YES;
    [self.loadModeButton addTarget:self action:@selector(changeLoadMode) forControlEvents:UIControlEventTouchUpInside];
    
    self.hiddenFloatAdButton = [[UIButton alloc] init];
    self.hiddenFloatAdButton.backgroundColor = [UIColor blackColor];
    [self.hiddenFloatAdButton setTitle:@"Hidden" forState:UIControlStateNormal];
    [self.hiddenFloatAdButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    self.hiddenFloatAdButton.layer.cornerRadius = 5;
    self.hiddenFloatAdButton.layer.masksToBounds = YES;
    [self.hiddenFloatAdButton addTarget:self action:@selector(hiddenFloatAd) forControlEvents:UIControlEventTouchUpInside];
    
    self.showAgainAfterHidingButton = [[UIButton alloc] init];
    self.showAgainAfterHidingButton.backgroundColor = [UIColor blackColor];
    [self.showAgainAfterHidingButton setTitle:@"ShowAgain" forState:UIControlStateNormal];
    [self.showAgainAfterHidingButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    self.showAgainAfterHidingButton.layer.cornerRadius = 5;
    self.showAgainAfterHidingButton.layer.masksToBounds = YES;
    [self.showAgainAfterHidingButton addTarget:self action:@selector(showAgainAfterHiding) forControlEvents:UIControlEventTouchUpInside];
    
    self.dismissVcButton = [[UIButton alloc] init];
    self.dismissVcButton.backgroundColor = [UIColor blackColor];
    [self.dismissVcButton setTitle:@"DismissVC" forState:UIControlStateNormal];
    [self.dismissVcButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    self.dismissVcButton.layer.cornerRadius = 5;
    self.dismissVcButton.layer.masksToBounds = YES;
    [self.dismissVcButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.resetFrameButton = [[UIButton alloc] init];
    self.resetFrameButton.backgroundColor = [UIColor blackColor];
    [self.resetFrameButton setTitle:@"resetFloatAdFrame" forState:UIControlStateNormal];
    [self.resetFrameButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    self.resetFrameButton.layer.cornerRadius = 5;
    self.resetFrameButton.layer.masksToBounds = YES;
    [self.resetFrameButton addTarget:self action:@selector(resetFloatAdFrame) forControlEvents:UIControlEventTouchUpInside];

    self.console = [[UITextView alloc] init];
    self.console.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.appID];
    [self.view addSubview:self.adUnitID];
    [self.view addSubview:self.xTextField];
    [self.view addSubview:self.yTextField];
    [self.view addSubview:self.widthTextField];
    [self.view addSubview:self.requestButton];
    [self.view addSubview:self.showButton];
    [self.view addSubview:self.destroyButton];
    [self.view addSubview:self.loadModeButton];
    [self.view addSubview:self.hiddenFloatAdButton];
    [self.view addSubview:self.showAgainAfterHidingButton];
    [self.view addSubview:self.dismissVcButton];
    [self.view addSubview:self.resetFrameButton];
    [self.view addSubview:self.console];
    
    [self.appID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(marginTop);
        make.width.equalTo(@240);
        make.height.mas_equalTo(height);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.adUnitID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.appID.mas_bottom).with.offset(margin);
        make.width.equalTo(self.appID.mas_width);
        make.height.equalTo(self.appID.mas_height);
        make.centerX.equalTo(self.appID.mas_centerX);
    }];
    
    [self.xTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.adUnitID.mas_bottom).with.offset(margin);
        make.width.equalTo(self.appID.mas_width).with.multipliedBy(0.25);
        make.height.equalTo(self.appID.mas_height);
        make.left.equalTo(self.appID.mas_left);
    }];
    
    [self.yTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.adUnitID.mas_bottom).with.offset(margin);
        make.width.equalTo(self.xTextField.mas_width);
        make.height.equalTo(self.appID.mas_height);
        make.centerX.equalTo(self.appID.mas_centerX);
    }];
    
    [self.widthTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.adUnitID.mas_bottom).with.offset(margin);
        make.width.equalTo(self.xTextField.mas_width);
        make.height.equalTo(self.appID.mas_height);
        make.right.equalTo(self.appID.mas_right);
    }];

    [self.requestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.xTextField.mas_bottom).with.offset(margin);
        make.width.equalTo(self.adUnitID.mas_width).with.multipliedBy(0.4);
        make.height.equalTo(self.adUnitID.mas_height);
        make.left.equalTo(self.adUnitID.mas_left);
    }];

    [self.showButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.xTextField.mas_bottom).with.offset(margin);
        make.width.equalTo(self.requestButton.mas_width);
        make.height.equalTo(self.requestButton.mas_height);
        make.right.equalTo(self.appID.mas_right);
    }];
    
    [self.hiddenFloatAdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.requestButton.mas_bottom).with.offset(margin);
        make.width.equalTo(self.requestButton.mas_width);
        make.height.equalTo(self.requestButton.mas_height);
        make.left.equalTo(self.requestButton.mas_left);
    }];
    
    [self.showAgainAfterHidingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.requestButton.mas_bottom).with.offset(margin);
        make.width.equalTo(self.requestButton.mas_width);
        make.height.equalTo(self.requestButton.mas_height);
        make.right.equalTo(self.showButton.mas_right);
    }];

    [self.destroyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hiddenFloatAdButton.mas_bottom).with.offset(margin);
        make.width.equalTo(self.hiddenFloatAdButton.mas_width);
        make.height.equalTo(self.hiddenFloatAdButton.mas_height);
        make.left.equalTo(self.hiddenFloatAdButton.mas_left);
    }];
    
    [self.dismissVcButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.showAgainAfterHidingButton.mas_bottom).with.offset(margin);
        make.width.equalTo(self.showAgainAfterHidingButton.mas_width);
        make.height.equalTo(self.showAgainAfterHidingButton.mas_height);
        make.centerX.equalTo(self.showAgainAfterHidingButton.mas_centerX);
    }];
    
    [self.loadModeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.destroyButton.mas_bottom).with.offset(margin);
        make.width.equalTo(self.appID.mas_width);
        make.height.equalTo(self.destroyButton.mas_height);
        make.centerX.equalTo(self.appID.mas_centerX);
    }];
    
    [self.resetFrameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loadModeButton.mas_bottom).with.offset(margin);
        make.width.equalTo(self.appID.mas_width);
        make.height.equalTo(self.destroyButton.mas_height);
        make.centerX.equalTo(self.appID.mas_centerX);
    }];

    [self.console mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.resetFrameButton.mas_bottom).with.offset(margin);
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.view.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

- (NSString *)removeSpaceAndNewline:(NSString *)str {
    NSString *temp = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    return text;
}

- (void)addLog:(NSString *)newLog {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.console.layoutManager.allowsNonContiguousLayout = NO;
        NSString *oldLog = weakSelf.console.text;
        NSString *text = [NSString stringWithFormat:@"%@\n%@", oldLog, newLog];
        if (oldLog.length == 0) {
            text = [NSString stringWithFormat:@"%@", newLog];
        }
        [weakSelf.console scrollRangeToVisible:NSMakeRange(text.length, 1)];
        weakSelf.console.text = text;
    });
}

- (void)requestFloatAd {
    if (!self.appID.text.length) {
        self.appID.text = @"788C58DC-8290-F665-3C87-E7B1DBE8DFCE";
    }
    if (!self.adUnitID.text.length) {
        self.adUnitID.text = @"D668394A-B1EA-E4AB-9917-61C41BE3F3B1";
    }
    if (self.floatAd) {
        [self.floatAd destroyFloatAd];
    }
    
    self.floatAd = [[AtmosplayFloatAd alloc]
                    initAndLoadAdWithAppID:self.appID.text
                    adUnitID:self.adUnitID.text
                    autoLoad:self.isAutoLoad];
    self.floatAd.delegate = self;
}

- (void)showFloatAd {
    if (!self.xTextField.text.length) {
        self.xTextField.text = @"20";
    }
    if (!self.yTextField.text.length) {
        self.yTextField.text = @"100";
    }
    if (!self.widthTextField.text.length) {
        self.widthTextField.text = @"100";
    }
    float x = [self.xTextField.text floatValue];
    float y = [self.yTextField.text floatValue];
    float width = [self.widthTextField.text floatValue];
    
    if (self.floatAd.isReady) {
        [self.floatAd showFloatAdWith:CGPointMake(x,y) width:width rootViewController:self];
    }
}

- (void)destroyFloatAd {
    [self.floatAd destroyFloatAd];
    self.floatAd.delegate = nil;
    self.floatAd = nil;
}

- (void)changeLoadMode {
    if (!self.isAutoLoad) {
        self.isAutoLoad = YES;
        [self.loadModeButton setTitle:@"Disable Auto Load" forState:UIControlStateNormal];
    } else {
        self.isAutoLoad = NO;
        [self.loadModeButton setTitle:@"Enable Auto Load" forState:UIControlStateNormal];
    }
}

- (void)hiddenFloatAd {
    [self.floatAd hiddenFloatAd];
}

- (void)showAgainAfterHiding {
    [self.floatAd showAgainAfterHiding];
}

- (void)dismissVC {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)resetFloatAdFrame {
    if (!self.xTextField.text.length) {
        self.xTextField.text = @"20";
    }
    if (!self.yTextField.text.length) {
        self.yTextField.text = @"100";
    }
    if (!self.widthTextField.text.length) {
        self.widthTextField.text = @"100";
    }
    float x = [self.xTextField.text floatValue];
    float y = [self.yTextField.text floatValue];
    float width = [self.widthTextField.text floatValue];
    
    [self.floatAd resetFloatAdFrameWith:CGPointMake(x, y) width:width rootViewController:self];
}

#pragma mark - Float Ad Delegate
/// Tells the delegate that an ad has been successfully loaded.
- (void)atmosplayFloatAdDidLoad:(AtmosplayFloatAd *)floatAd {
    [self addLog:@"atmosplayFloatAdDidLoad"];
}
/// Tells the delegate that a request failed.
- (void)atmosplayFloatAd:(AtmosplayFloatAd *)floatAd DidFailWithError:(NSError *)error {
    NSString *errorString = [[NSString alloc] initWithFormat:@"DidFailWithError %@",error.description];
    [self addLog:errorString];
}
/// Tells the delegate that the user should be rewarded.
- (void)atmosplayFloatAdDidRewardUser:(AtmosplayFloatAd *)floatAd {
    [self addLog:@"atmosplayFloatAdDidRewardUser"];
}
/// Tells the delegate that user starts playing the ad.
- (void)atmosplayFloatAdDidStartPlaying:(AtmosplayFloatAd *)floatAd {
    [self addLog:@"atmosplayFloatAdDidStartPlaying"];
}
/// Tells the delegate that the ad is being fully played.
- (void)atmosplayFloatAdDidEndPlaying:(AtmosplayFloatAd *)floatAd {
    [self addLog:@"atmosplayFloatAdDidEndPlaying"];
}
/// Tells the delegate that the landing page did present on the screen.
- (void)atmosplayFloatAdDidPresentLandingPage:(AtmosplayFloatAd *)floatAd {
    [self addLog:@"atmosplayFloatAdDidPresentLandingPage"];
}
/// Tells the delegate that the ad did animate off the screen.
- (void)atmosplayFloatAdDidDismissScreen:(AtmosplayFloatAd *)floatAd {
    [self addLog:@"atmosplayFloatAdDidDismissScreen"];
}
/// Tells the delegate that the ad is clicked
- (void)atmosplayFloatAdDidClick:(AtmosplayFloatAd *)floatAd {
    [self addLog:@"atmosplayFloatAdDidClick"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.console resignFirstResponder];
    [self.appID resignFirstResponder];
    [self.adUnitID resignFirstResponder];
    [self.xTextField resignFirstResponder];
    [self.yTextField resignFirstResponder];
    [self.widthTextField resignFirstResponder];
}

@end
