//
//  MSRewardVideoViewController.m
//  MSAdSDKDev
//
//  Created by Liumaos on 2020/7/20.
//  Copyright © 2020 XiXiHaha. All rights reserved.
//

#import "MSRewardVideoViewController.h"


@interface MSRewardVideoViewController ()<MSRewardVideoAdDelegate>

@property(nonatomic,strong) MSRewardVideoAd *rewardAd;


@property (strong, nonatomic)  UIButton    *loadBtn;
@property (strong, nonatomic)  UITextField *defaultPidTF;
@property (strong, nonatomic)  UIButton    *playBtn;

@property (strong, nonatomic)  UILabel     *statusLabel;

@end

@implementation MSRewardVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    
    self.defaultPidTF.text        = self.defaultPid;
    self.defaultPidTF.placeholder = self.defaultPid;
    self.playBtn.enabled          = NO;

}

- (void)loadAd:(id)sender {
    
    self.statusLabel.text = @"正在加载....";
    self.playBtn.enabled  = NO;

    self.rewardAd = [[MSRewardVideoAd alloc] initWithCurController:self];
    self.rewardAd.delegate = self;
    NSString *pid = self.defaultPidTF.text ?:self.defaultPid;
    
    [self.rewardAd loadRewardVideoAd:pid];
    
}

- (void)playAd:(id)sender {
    
    [self.rewardAd showRewardVideoAd];

}

#pragma mark- MSRewardVideoAdDelegate

- (void)msRewardVideoLoaded:(MSRewardVideoAd *)msRewardVideoAd {
    
    self.playBtn.enabled  = YES;
    self.statusLabel.text = @"广告已加载";
    
}
- (void)msRewardVideoCached:(MSRewardVideoAd *)msRewardVideoAd {
        
    self.playBtn.enabled  = YES;
    self.statusLabel.text = @"广告视频已缓存";
    
}

- (void)msRewardVideoClicked:(MSRewardVideoAd *)msRewardVideoAd {
    
}

- (void)msRewardVideoClosed:(MSRewardVideoAd *)msRewardVideoAd {
    
}

- (void)msRewardVideoError:(MSRewardVideoAd *)msRewardVideoAd error:(NSError *)error {
    
}

-(void)msRewardVideoPlatformError:(MSRewardVideoAd *)msRewardVideoAd
                         platform:(MSShowType)platform
                            error:(NSError *)error{
    
}

- (void)msRewardVideoFinish:(MSRewardVideoAd *)msRewardVideoAd {
    
}



- (void)msRewardVideoReward:(MSRewardVideoAd *)msRewardVideoAd {
    
}

- (void)msRewardVideoShow:(MSRewardVideoAd *)msRewardVideoAd {
    
}

- (void)msRewardVideoWillShow:(MSRewardVideoAd *)msRewardVideoAd {
    
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
    self.loadBtn = loadBtn;
    
    
    UIButton * playBtn = [MSQuickCreate longActionBtn];
    [playBtn setTitle:@"展示广告" forState:UIControlStateNormal];
    [playBtn addTarget:self
              action:@selector(playAd:)
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
