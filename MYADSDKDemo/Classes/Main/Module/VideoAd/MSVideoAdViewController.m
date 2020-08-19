//
//  MSVideoAdViewController.m
//  MSAdSDKDev
//
//  Created by Liumaos on 2020/7/23.
//  Copyright © 2020 Adxdata. All rights reserved.
//

#import "MSVideoAdViewController.h"

@interface MSVideoAdViewController ()<MSVideoAdDelegate>

@property (strong, nonatomic)  UITextField *defaultPidTF;
@property (strong, nonatomic)  UISwitch *muteSwitch;
@property (strong, nonatomic)  UISlider *sizeSlider;
@property (strong, nonatomic)  UIView *containView;

@property(nonatomic,strong) MSVideoAd *videoAd;

@end

@implementation MSVideoAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    self.defaultPidTF.text = self.defaultPid;
    
}

-(void) loadAd{
    
    
    if (_videoAd) {
        [_videoAd removeFromSuperview];
        _videoAd = nil;
    }
    MSVideoAd *videoAd = [[MSVideoAd alloc]initWithFrame:self.containView.bounds
                                               presentVc:self];
    NSString *pid = self.defaultPidTF.text.length ? self.defaultPidTF.text : self.defaultPid;
    videoAd.delegate = self;
    [videoAd loadAdAndShowAd:pid];
    self.videoAd = videoAd;
    [self.containView addSubview:self.videoAd];
    
    
}

-(void)muteClick:(UISwitch *)mute{
    self.videoAd.muted = mute.on;
}

- (void)playOrPauseAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.videoAd pauseVideo];
    }else{
        [self.videoAd playVideo];
    }
}

- (void)changeFrame:(UISlider *)sender {
    
    CGFloat rate       = sender.value;
    self.videoAd.frame = CGRectMake(0, 0,self.containView.bounds.size.width * rate , self.containView.bounds.size.height * rate);
}


#pragma mark- MSVideoAdDelegate

- (void)msVideoLoad:(MSVideoAd *)videoAd{
    
}

- (void)msVideoShow:(MSVideoAd *)videoAd{
    
}

- (void)msVideoError:(MSVideoAd *)videoAd
               error:(NSError *)error{
    
}


-(void)msVideoPlatformError:(MSShowType)platform
                         ad:(MSVideoAd *)videoAd
                      error:(NSError *)error{
    
}


- (void)msVideoClick:(MSVideoAd *)videoAd{
    
}


- (void)msVideoCompletion:(MSVideoAd *)videoAd{
    
}


#pragma mark -SetUpView

-(void) setUpView{
    
    self.containView = [[UIView alloc]initWithFrame:CGRectZero];
    self.containView.layer.borderWidth   = 0.5;
    self.containView.layer.borderColor   = [UIColor lightGrayColor].CGColor;
    self.containView.layer.cornerRadius  = 2;
    self.containView.layer.masksToBounds = YES;
    [self.view addSubview:self.containView];
    
    
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectZero];
    slider.maximumValue = 1;
    slider.minimumValue = 0.6;
    
    [slider addTarget:self action:@selector(changeFrame:) forControlEvents:UIControlEventValueChanged];
    slider.value = 1.0;
    [self.view addSubview:slider];
    
    UILabel *sliderDec = [MSQuickCreate statusLabel];
    sliderDec.text     = @"调整尺寸";
    [self.view addSubview:sliderDec];
    
    
    UISwitch *muteSwitch = [[UISwitch alloc]init];
    [self.view addSubview:muteSwitch];
    self.muteSwitch = muteSwitch;
    [self.muteSwitch addTarget:self
                        action:@selector(muteClick:)
              forControlEvents:UIControlEventValueChanged];
    
    
    UILabel *muteDec = [MSQuickCreate statusLabel];
    muteDec.text     = @"是否静音";
    [self.view addSubview:muteDec];
    
    self.defaultPidTF = [MSQuickCreate defaultPidTextField];
    [self.view addSubview:self.defaultPidTF];
    
    UIButton * showBtn = [MSQuickCreate longActionBtn];
    [showBtn setTitle:@"加载广告" forState:UIControlStateNormal];
    [showBtn addTarget:self
                action:@selector(loadAd)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn];
    
    
    UIButton * playBtn = [MSQuickCreate longActionBtn];
    [playBtn setTitle:@"播放" forState:UIControlStateNormal];
    [playBtn setTitle:@"暂停" forState:UIControlStateSelected];
    [playBtn addTarget:self
                action:@selector(playOrPauseAction:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    
    
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.width.equalTo(@320);
        make.height.equalTo(@180);
        make.centerX.offset(0);
    }];
    
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.height.equalTo(@20);
        make.width.equalTo(@200);
    }];
    
    [sliderDec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(slider.mas_bottom).offset(5);
        make.centerX.offset(0);
    }];
    
    [muteSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sliderDec.mas_bottom).offset(20);
        make.centerX.offset(0);
    }];
    
    [muteDec mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(muteSwitch.mas_bottom).offset(5);
        make.centerX.offset(0);
        make.bottom.equalTo(self.defaultPidTF.mas_top).offset(-20);
    }];
    
    [self.defaultPidTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@48);
        make.leading.offset(20);
        make.trailing.offset(-20);
    }];
    
    [showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.defaultPidTF.mas_bottom).offset(20);
        make.height.equalTo(@48);
        make.leading.offset(20);
        make.trailing.offset(-20);
        
    }];
    
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(showBtn.mas_bottom).offset(20);
        make.height.equalTo(@48);
        make.leading.offset(20);
        make.trailing.offset(-20);
        make.bottom.offset(-60);
    }];
    
}


@end
