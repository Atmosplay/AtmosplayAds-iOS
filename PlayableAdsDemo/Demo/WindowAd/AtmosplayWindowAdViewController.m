//
//  AtmosplayWindowAdViewController.m
//  PlayableAds_Example
//
//  Created by jdy on 2020/3/23.
//  Copyright © 2020 AtmosplayAds. All rights reserved.
//

#import "AtmosplayWindowAdViewController.h"
#import <AtmosplayAds/AtmosplayWindowAd.h>
#import <Masonry/Masonry.h>
#import <AtmosplayAds/PAUtils.h>

@interface AtmosplayWindowAdViewController () <AtmosplayWindowAdDelegate>
@property (nonatomic) UITextField *appID;
@property (nonatomic) UITextField *adUnitID;
@property (nonatomic) UITextField *xTextField;
@property (nonatomic) UITextField *yTextField;
@property (nonatomic) UITextField *angleTextField;
@property (nonatomic) UITextField *widthTextField;
@property (nonatomic) UIButton *requestButton;
@property (nonatomic) UIButton *showButton;
@property (nonatomic) UIButton *destroyButton;
@property (nonatomic) UIButton *dismissVcButton;
@property (nonatomic) UITextView *console;

@property (nonatomic) AtmosplayWindowAd *windowAd;
@end

@implementation AtmosplayWindowAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    self.angleTextField = [[UITextField alloc] init];
    self.angleTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.angleTextField.backgroundColor = [UIColor blackColor];
    self.angleTextField.placeholder = @"angle";
    self.angleTextField.textColor = [UIColor whiteColor];
    [self.angleTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.angleTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.angleTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
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
    [self.requestButton addTarget:self action:@selector(requestWindowAd) forControlEvents:UIControlEventTouchUpInside];

    self.showButton = [[UIButton alloc] init];
    self.showButton.backgroundColor = [UIColor blackColor];
    [self.showButton setTitle:@"Show" forState:UIControlStateNormal];
    [self.showButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    self.showButton.layer.cornerRadius = 5;
    self.showButton.layer.masksToBounds = YES;
    [self.showButton addTarget:self action:@selector(showWindowAd) forControlEvents:UIControlEventTouchUpInside];

    self.destroyButton = [[UIButton alloc] init];
    self.destroyButton.backgroundColor = [UIColor blackColor];
    [self.destroyButton setTitle:@"Close" forState:UIControlStateNormal];
    [self.destroyButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    self.destroyButton.layer.cornerRadius = 5;
    self.destroyButton.layer.masksToBounds = YES;
    [self.destroyButton addTarget:self action:@selector(closeWindowAd) forControlEvents:UIControlEventTouchUpInside];
    
    self.dismissVcButton = [[UIButton alloc] init];
    self.dismissVcButton.backgroundColor = [UIColor blackColor];
    [self.dismissVcButton setTitle:@"DismissVC" forState:UIControlStateNormal];
    [self.dismissVcButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    self.dismissVcButton.layer.cornerRadius = 5;
    self.dismissVcButton.layer.masksToBounds = YES;
    [self.dismissVcButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];

    self.console = [[UITextView alloc] init];
    self.console.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.appID];
    [self.view addSubview:self.adUnitID];
    [self.view addSubview:self.xTextField];
    [self.view addSubview:self.yTextField];
    [self.view addSubview:self.angleTextField];
    [self.view addSubview:self.widthTextField];
    [self.view addSubview:self.requestButton];
    [self.view addSubview:self.showButton];
    [self.view addSubview:self.destroyButton];
    [self.view addSubview:self.dismissVcButton];
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
        make.width.equalTo(self.appID.mas_width).with.multipliedBy(0.4);
        make.height.equalTo(self.appID.mas_height);
        make.left.equalTo(self.adUnitID.mas_left);
    }];
    
    [self.yTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.adUnitID.mas_bottom).with.offset(margin);
        make.width.equalTo(self.xTextField.mas_width);
        make.height.equalTo(self.appID.mas_height);
        make.right.equalTo(self.adUnitID.mas_right);
    }];
    
    [self.angleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.xTextField.mas_bottom).with.offset(margin);
        make.width.equalTo(self.xTextField.mas_width);
        make.height.equalTo(self.appID.mas_height);
        make.left.equalTo(self.xTextField.mas_left);
    }];
    
    [self.widthTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.xTextField.mas_bottom).with.offset(margin);
        make.width.equalTo(self.xTextField.mas_width);
        make.height.equalTo(self.appID.mas_height);
        make.right.equalTo(self.yTextField.mas_right);
    }];

    [self.requestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.angleTextField.mas_bottom).with.offset(margin);
        make.width.equalTo(self.adUnitID.mas_width).with.multipliedBy(0.4);
        make.height.equalTo(self.adUnitID.mas_height);
        make.left.equalTo(self.adUnitID.mas_left);
    }];

    [self.showButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.angleTextField.mas_bottom).with.offset(margin);
        make.width.equalTo(self.requestButton.mas_width);
        make.height.equalTo(self.requestButton.mas_height);
        make.right.equalTo(self.adUnitID.mas_right);
    }];
    
    [self.destroyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.requestButton.mas_bottom).with.offset(margin);
        make.width.equalTo(self.requestButton.mas_width);
        make.height.equalTo(self.requestButton.mas_height);
        make.left.equalTo(self.showButton.mas_left);
    }];
    
    [self.dismissVcButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.requestButton.mas_bottom).with.offset(margin);
        make.width.equalTo(self.requestButton.mas_width);
        make.height.equalTo(self.requestButton.mas_height);
        make.left.equalTo(self.requestButton.mas_left);
    }];

    [self.console mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dismissVcButton.mas_bottom).with.offset(margin);
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

- (void)requestWindowAd {
    if (!self.appID.text.length) {
        self.appID.text = @"788C58DC-8290-F665-3C87-E7B1DBE8DFCE";
    }
    if (!self.adUnitID.text.length) {
        self.adUnitID.text = @"667C3FA5-0151-20A9-31E3-E452B5D501B3";
    }
    if (self.windowAd) {
        [self closeWindowAd];
    }
    self.windowAd = [[AtmosplayWindowAd alloc]
                    initAndLoadAdWithAppID:self.appID.text
                    adUnitID:self.adUnitID.text];
    self.windowAd.delegate = self;
}

- (void)showWindowAd {
    if (!self.xTextField.text.length) {
        self.xTextField.text = @"20";
    }
    if (!self.yTextField.text.length) {
        self.yTextField.text = @"100";
    }
    if (!self.angleTextField.text.length) {
        self.angleTextField.text = @"5";
    }
    if (!self.widthTextField.text.length) {
        self.widthTextField.text = @"150";
    }
    float x = [self.xTextField.text floatValue];
    float y = [self.yTextField.text floatValue];
    float angel = [self.angleTextField.text floatValue];
    float width = [self.widthTextField.text floatValue];
    
    if (self.windowAd.isReady) {
        [self addLog:@"isReady = Yes"];
        [self.windowAd showWindowAdWith:CGPointMake(x, y)
                                  width:width
                         transformAngle:angel
                     rootViewController:self];
    } else {
        [self addLog:@"isReady = No"];
    }
}

- (void)closeWindowAd {
    [self.windowAd closeWindowAd];
}

- (void)dismissVC {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.console resignFirstResponder];
    [self.appID resignFirstResponder];
    [self.adUnitID resignFirstResponder];
    [self.xTextField resignFirstResponder];
    [self.yTextField resignFirstResponder];
    [self.angleTextField resignFirstResponder];
    [self.widthTextField resignFirstResponder];
}

#pragma mark - window ad delegate
/// Tells the delegate that an ad has been successfully loaded.
- (void)atmosplayWindowAdDidLoad:(AtmosplayWindowAd *)windowAd {
    [self addLog:@"atmosplayWindowAdDidLoad"];
}
/// Tells the delegate that a request failed.
- (void)atmosplayWindowAd:(AtmosplayWindowAd *)windowAd DidFailWithError:(NSError *)error {
    NSString *errorStr = [[NSString alloc] initWithFormat:@"DidFailWithError,%@",error.description];
    [self addLog:errorStr];
}
/// Tells the delegate that user starts playing the ad.
- (void)atmosplayWindowAdDidStartPlaying:(AtmosplayWindowAd *)windowAd {
    [self addLog:@"atmosplayWindowAdDidStartPlaying"];
}
/// Tells the delegate that the ad is being fully played.
- (void)atmosplayWindowAdDidEndPlaying:(AtmosplayWindowAd *)windowAd {
    [self addLog:@"atmosplayWindowAdDidEndPlaying"];
}
- (void)atmosplayWindowAdDidFailToPlay:(AtmosplayWindowAd *)windowAd {
    [self addLog:@"atmosplayWindowAdDidFailToPlay"];
}
/// Tells the delegate that the ad did animate off the screen.
- (void)atmosplayWindowAdDidDismissScreen:(AtmosplayWindowAd *)windowAd {
    [self addLog:@"atmosplayWindowAdDidDismissScreen"];
}
/// Tells the delegate that the ad is clicked
- (void)atmosplayWindowAdDidClick:(AtmosplayWindowAd *)windowAd {
    [self addLog:@"atmosplayWindowAdDidClick"];
}

@end
