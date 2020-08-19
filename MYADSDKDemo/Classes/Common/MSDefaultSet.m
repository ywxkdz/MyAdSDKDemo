//
//  MSDefaultSet.m
//  MSAdSDKDev
//
//  Created by Liumaos on 2020/7/17.
//  Copyright © 2020 XiXiHaha. All rights reserved.
//

#import "MSDefaultSet.h"

@implementation MSDefaultSet

+(NSDictionary *)defaultIdPriders{
    
    return @{
        MSPlatformNameMS :@"MSIdProvider",
        MSPlatformNameBU :@"BUIdProvider",
        MSPlatformNameGDT:@"GDTIdProvider",
        MSPlatformNameBD :@"BDIdProvider",
        MSPlatformNameDN :@"DNAdIdProvider"
    };
}

+ (NSDictionary *)defaultAdVcs{
    
    return @{
        @(MSAdTypeSplash) :@"MSSplashViewController",
        @(MSAdTypeReward) :@"MSRewardVideoViewController",
        @(MSAdTypeBanner) :@"MSBannerViewController",
        @(MSAdTypeInterstitial):@"MSInterstitialViewController",
        @(MSAdTypeVideoAd):@"MSVideoAdViewController",
        @(MSAdTypeFeed)   :@"MSFeedViewController",
        @(MSAdTypeFeedPreRender)   :@"MSPreRenderViewController"

    };
}

@end
