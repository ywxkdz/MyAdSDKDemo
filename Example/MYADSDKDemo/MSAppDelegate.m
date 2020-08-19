//
//  MSAppDelegate.m
//  MSAdSDK
//
//  Created by Liumao on 08/10/2020.
//  Copyright (c) 2020 Liumao. All rights reserved.
//

#import "MSAppDelegate.h"
#import "HomeViewController.h"
#import "MSDemoSplashViewController.h"
#import <MSAdSDK/MSAdSDK.h>

@interface MSAppDelegate ()<MSDemoSplashDelegate>

@end


@implementation MSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setUpSDK];
    
    [self setUpMainVc];
    
    return YES;
}

-(void) setUpSDK{
    
    NSString *appid = @"101647";
    [MSAdSDK setAppId:appid];  //设置AppID
    [MSAdSDK setTestMode:YES]; // 切换测试服务器，默认为生产服务器
    [MSAdSDK setLogLevel:MSLogError];
    
    [MSConfig setYob:@"2000"];
    [MSConfig setGender:MSGenderFemale];
}

-(void) setUpMainVc{
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    
    //    [self startWithSplashAd];
    
    [self startWithoutSplashAd];
    
}

-(void) startWithSplashAd{
    
    MSDemoSplashViewController *splashvc = [[MSDemoSplashViewController alloc]initWithNibName:nil bundle:nil];
    splashvc.delegate = self;
    self.window.rootViewController = splashvc;
}

-(void)startWithoutSplashAd{
    
    UIViewController *vc = [[HomeViewController alloc]initWithNibName:nil bundle:nil];
    
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
    
    self.window.rootViewController = navi;
    
}

#pragma mark-

-(void)splashAdDidFinished{
    
    [self startWithoutSplashAd];
}

@end

