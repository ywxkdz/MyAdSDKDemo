//
//  MSDemoSplashViewController.m
//  MSAdSDKDev
//
//  Created by Liumaos on 2020/8/5.
//  Copyright © 2020 Adxdata. All rights reserved.
//

#import "MSDemoSplashViewController.h"
#import "IdProviderFactory.h"

@interface MSDemoSplashViewController ()<MSSplashAdDelegate>

@property(nonatomic,strong) MSSplashAd *splash;

@end

@implementation MSDemoSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadAd];
}

-(void)loadAd{
    
    MSSplashAd *splash = [[MSSplashAd alloc]init];
    self.splash     = splash;
    splash.delegate = self;
    
    NSString *pid = [IdProviderFactory getPidFor:MSPlatformNameMS adType:MSAdTypeSplash];
    
    [self.splash loadAdAndShowSplashAd:pid];
}

-(void)splashAdDidFinished{
    
    if ([self.delegate respondsToSelector:@selector(splashAdDidFinished)]) {
        [self.delegate splashAdDidFinished];
    }
}

#pragma mark- <MSSplashAdDelegate>

- (void)msSplashClicked:(MSSplashAd *)splashAd {
    
}

- (void)msSplashClosed:(MSSplashAd *)splashAd {
    
    [self splashAdDidFinished];
}

- (void)msSplashDetailClosed:(MSSplashAd *)splashAd {
    
}

- (void)msSplashError:(MSSplashAd *)splashAd
            withError:(NSError *)error {
    
    [self splashAdDidFinished];
}

- (void)msSplashLoaded:(MSSplashAd *)splashAd {
    
}

-(void)msSplashPresent:(MSSplashAd *)splashAd{
    
    
}

- (void)msSplashShow:(MSSplashAd *)splashAd {
    
}

- (void)msSplashSkip:(MSSplashAd *)splashAd {
    
    [self splashAdDidFinished];
}

- (void)msSplashWillClosed:(MSSplashAd *)splashAd {
    
}

- (void)msSplashStartLoaded:(MSSplashAd *)splashAd {
    
}
@end
