//
//  MSBannerViewController.m
//  MSAdSDKDev
//
//  Created by Liumaos on 2020/7/21.
//  Copyright © 2020 Adxdata. All rights reserved.
//

#import "MSBannerViewController.h"

@interface MSBannerViewController ()<MSBannerViewDelegate>

@property (strong, nonatomic)  UIView *containView;
@property (strong, nonatomic)  UITextField  *defaultPidTF;
@property(nonatomic,strong)    MSBannerView *bannerView;
@property (strong, nonatomic)  UIButton     *showCloseBtn;


@end

@implementation MSBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    self.defaultPidTF.text = self.defaultPid;
    self.showCloseBtn.selected = YES;
    
}
-(MSBannerView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[MSBannerView alloc]initWithFrame:self.containView.bounds curController:self];
        [self.containView addSubview:_bannerView];
    }
    return _bannerView;
}
- (void)showBannerAd:(id)sender {
    
    NSString *pid = self.defaultPidTF.text.length ? self.defaultPidTF.text : self.defaultPid;
    self.bannerView.delegate = self;
    [self.bannerView loadAdAndShow:self pid:pid];
}

- (void)removeBannerAd:(id)sender {
    
    [self.bannerView dismiss];
    self.bannerView = nil;
    
}
- (void)showOrHideCloseBtn:(UIButton*)sender {
    
    sender.selected = !sender.selected;
    self.bannerView.showCloseBtn = !sender.selected;
    
}
-(void)msBannerShow:(MSBannerView *)msBannerAd{
    
}
-(void)msBannerClosed:(MSBannerView *)msBannerAd{
    [self.bannerView dismiss];
    _bannerView = nil;
}
-(void)msBannerLoaded:(MSBannerView *)msBannerAd{
    
}
-(void)msBannerClicked:(MSBannerView *)msBannerAd{
    
}
-(void)msBannerDetailShow:(MSBannerView *)msBannerAd{
    
}
-(void)msBannerError:(MSBannerView *)msBannerAd error:(NSError *)error{
    
}


-(void)msBannerPlatformError:(MSShowType)platform
                    bannerAd:(MSBannerView *)msBannerAd
                       error:(NSError *)error{
    
}

-(void)msBannerDetailClosed:(MSBannerView *)msBannerAd{
    
}

#pragma mark -SetUpView

-(void) setUpView{
    
    self.containView  = [[UIView alloc]initWithFrame:CGRectZero];
    self.containView.layer.borderWidth   = 0.5;
    self.containView.layer.borderColor   = [UIColor lightGrayColor].CGColor;
    self.containView.layer.cornerRadius  = 3;
    self.containView.layer.masksToBounds = YES;
    [self.view addSubview:self.containView];
    
    self.defaultPidTF = [MSQuickCreate defaultPidTextField];
    [self.view addSubview:self.defaultPidTF];
    
    UIButton * showBtn = [MSQuickCreate longActionBtn];
    [showBtn setTitle:@"展示广告" forState:UIControlStateNormal];
    [showBtn addTarget:self
                action:@selector(showBannerAd:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn];
    
    
    UIButton * removeBtn = [MSQuickCreate longActionBtn];
    [removeBtn setTitle:@"移除广告" forState:UIControlStateNormal];
    [removeBtn addTarget:self
                  action:@selector(removeBannerAd:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeBtn];
    
    
    UIButton * showCloseBtn = [MSQuickCreate longActionBtn];
    [showCloseBtn setTitle:@"显示 关闭按钮" forState:UIControlStateSelected];
    [showCloseBtn setTitle:@"隐藏 关闭按钮" forState:UIControlStateNormal];
    [showCloseBtn addTarget:self
                     action:@selector(showOrHideCloseBtn:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showCloseBtn];
    self.showCloseBtn = showCloseBtn;
    
    
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(100);
        make.width.equalTo(@300);
        make.height.equalTo(@75);
        make.centerX.offset(0);
        
    }];
    
    [self.defaultPidTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@48);
        make.leading.offset(20);
        make.trailing.offset(-20);
        
    }];
    
    [showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@48);
        make.leading.offset(20);
        make.trailing.offset(-20);
        make.top.equalTo(self.defaultPidTF.mas_bottom).offset(20);
        
    }];
    
    [removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@48);
        make.leading.offset(20);
        make.trailing.offset(-20);
        make.top.equalTo(showBtn.mas_bottom).offset(20);
        
    }];
    
    [self.showCloseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@48);
        make.leading.offset(20);
        make.trailing.offset(-20);
        make.bottom.offset(-60);
        make.top.equalTo(removeBtn.mas_bottom).offset(20);
        
    }];
}

@end
