//
//  MSInterstitialViewController.m
//  MSAdSDKDev
//
//  Created by Liumaos on 2020/7/23.
//  Copyright © 2020 Adxdata. All rights reserved.
//

#import "MSInterstitialViewController.h"

@interface MSInterstitialViewController ()<MSInterstitialDelegate>

@property (strong, nonatomic)  UITextField *defaultPidTF;

@property (strong, nonatomic)  UILabel     *statusLabel;

@property (strong, nonatomic)  UIButton    *playBtn;

@property(nonatomic,strong) MSInterstitialAd *interstitialAd;


@end

@implementation MSInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.playBtn.enabled = NO;
    self.defaultPidTF.text = self.defaultPid;
    self.statusLabel.text = @"";
    
}

- (void)loadAd:(UIButton *)sender {
    
    self.playBtn.enabled = NO;
    self.statusLabel.text = @"加载中";
    self.interstitialAd = [[MSInterstitialAd alloc]initWithCurController:self];
    self.interstitialAd.delegate = self;
    NSString *pid = self.defaultPidTF.text.length ? self.defaultPidTF.text : self.defaultPid;
    [self.interstitialAd loadAd:pid];
}

- (void)showAd:(UIButton *)sender {
    
    [self.interstitialAd showAd];
}

#pragma mark- Delegate

- (void)msInterstitialLoaded:(MSInterstitialAd *)msInterstitialAd{
    self.playBtn.enabled = YES;
    self.statusLabel.text = @"已加载";
}

- (void)msInterstitialError:(MSInterstitialAd *)msInterstitialAd
                      error:(NSError *)error{
    
    NSString *err = error.localizedDescription;
    if (err.length>0) {
        self.statusLabel.text = err;
    }else{
        self.statusLabel.text = @"广告加载异常，稍后再试";
    }
}


-(void)msInterstitialPlatformError:(MSShowType)platform
                                ad:(MSInterstitialAd *)msInterstitialAd
                             error:(NSError *)error{
    
}

- (void)msInterstitialShow:(MSInterstitialAd *)msInterstitialAd{
    
}

- (void)msInterstitialClosed:(MSInterstitialAd *)msInterstitialAd{
 
    self.statusLabel.text = @"";

}

- (void)msInterstitialClicked:(MSInterstitialAd *)msInterstitialAd{
    
}

- (void)msInterstitialDetailClosed:(MSInterstitialAd *)msInterstitialAd{
    
    self.statusLabel.text = @"";
    
}


#pragma mark -SetUpView

-(void) setUpView{
    
    self.defaultPidTF = [MSQuickCreate defaultPidTextField];
    
    [self.view addSubview:self.defaultPidTF];
    
    UIButton * loadBtn = [MSQuickCreate longActionBtn];
    [loadBtn setTitle:@"加载广告" forState:UIControlStateNormal];
    [loadBtn addTarget:self
                action:@selector(loadAd:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadBtn];
    
    
    UIButton * playBtn = [MSQuickCreate longActionBtn];
    [playBtn setTitle:@"展示广告" forState:UIControlStateNormal];
    [playBtn addTarget:self
              action:@selector(showAd:)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    self.playBtn = playBtn;
    
    self.statusLabel = [MSQuickCreate statusLabel];
    [self.view addSubview:self.statusLabel];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.equalTo(self.defaultPidTF.mas_top).offset(-10);
    }];
    
    [self.defaultPidTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@48);
        make.leading.offset(20);
        make.trailing.offset(-20);
        
    }];
    
    [loadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@48);
        make.leading.offset(20);
        make.trailing.offset(-20);
        make.top.equalTo(self.defaultPidTF.mas_bottom).offset(20);
        
    }];
    
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@48);
        make.leading.offset(20);
        make.trailing.offset(-20);
        make.bottom.offset(-60);
        make.top.equalTo(loadBtn.mas_bottom).offset(20);
        
    }];
}

@end
