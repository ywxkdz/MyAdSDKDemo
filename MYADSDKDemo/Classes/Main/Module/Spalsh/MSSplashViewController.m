//
//  MSSplashViewController.m
//  MSAdSDKDev
//
//  Created by Liumaos on 2020/7/17.
//  Copyright © 2020 XiXiHaha. All rights reserved.
//

#import "MSSplashViewController.h"

@interface MSSplashViewController ()<MSSplashAdDelegate>

@property (strong, nonatomic)  UITextField *defaultPidTF;

@property(nonatomic,strong) MSSplashAd *splash;

@end

@implementation MSSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    
    self.defaultPidTF.placeholder = self.defaultPid;
    self.defaultPidTF.text        = self.defaultPid;
    
}

- (void)clickLoadFull:(UIButton*)sender{
    
    MSSplashAd *splash = [[MSSplashAd alloc]init];
    self.splash     = splash;
    splash.delegate = self;
    NSString *pid   = self.defaultPidTF.text.length ? self.defaultPidTF.text:self.defaultPid;
    
    [self.splash loadAdAndShowSplashAd:pid];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [splash cancel];
    });
}

- (void)clickLoadHalf:(UIButton*)sender{
    
    MSSplashAd *splash = [[MSSplashAd alloc]init];
    self.splash = splash;
    splash.delegate   = self;
    NSString *pid   = self.defaultPidTF.text.length ? self.defaultPidTF.text:self.defaultPid;
    splash.bottomView = [self bottomView];
    
    [self.splash loadAdAndShowSplashAd:pid];
    
}

-(UIView *)bottomView{
    
    CGFloat screenWidth  = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIView * bottomView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight * 0.25)];
    bottomView.backgroundColor = UIColor.whiteColor;
    
    UIImage *image = [UIImage imageNamed:@"logo"];
    UIImageView *logoView = [[UIImageView alloc] initWithImage:image];
    //    logoView.contentMode =  UIViewContentModeCenter;
    CGFloat width  = 114;
    CGFloat height = 40;
    logoView.frame = CGRectMake((screenWidth - width) / 2, (screenHeight * 0.25 - height) / 2, width, height) ;
    [bottomView addSubview:logoView];
    
    return bottomView;
}


#pragma mark- <MSSplashAdDelegate>

- (void)msSplashClicked:(MSSplashAd *)splashAd {
    
}

- (void)msSplashClosed:(MSSplashAd *)splashAd {
    
}

- (void)msSplashDetailClosed:(MSSplashAd *)splashAd {
    
}

- (void)msSplashError:(MSSplashAd *)splashAd withError:(NSError *)error {
    
}

-(void)msSplashPlatformError:(MSShowType)platform
                    splashAd:(MSSplashAd *)splashAd
                       Error:(NSError *)error{
    
    
}

- (void)msSplashLoaded:(MSSplashAd *)splashAd {
    
}

-(void)msSplashPresent:(MSSplashAd *)splashAd{
    
}

- (void)msSplashShow:(MSSplashAd *)splashAd {
    
}

- (void)msSplashSkip:(MSSplashAd *)splashAd {
    
}

- (void)msSplashWillClosed:(MSSplashAd *)splashAd {
    
}

- (void)msSplashStartLoaded:(MSSplashAd *)splashAd {
    
}




#pragma mark -SetUpView

-(void) setUpView{
    
    self.defaultPidTF = [MSQuickCreate defaultPidTextField];
    [self.view addSubview:self.defaultPidTF];
    
    UIButton * fullBtn = [MSQuickCreate longActionBtn];
    [fullBtn setTitle:@"全屏展示" forState:UIControlStateNormal];
    [fullBtn addTarget:self
                action:@selector(clickLoadFull:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fullBtn];
    
    
    UIButton * halfBtn = [MSQuickCreate longActionBtn];
    [halfBtn setTitle:@"半屏展示" forState:UIControlStateNormal];
    [halfBtn addTarget:self
              action:@selector(clickLoadHalf:)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:halfBtn];
    
    
    [self.defaultPidTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@48);
        make.leading.offset(20);
        make.trailing.offset(-20);
    }];
    
    [fullBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@48);
        make.leading.offset(20);
        make.trailing.offset(-20);
        make.top.equalTo(self.defaultPidTF.mas_bottom).offset(20);
        
    }];
    
    [halfBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@48);
        make.leading.offset(20);
        make.trailing.offset(-20);
        make.bottom.offset(-60);
        make.top.equalTo(fullBtn.mas_bottom).offset(20);
        
    }];
}




@end
