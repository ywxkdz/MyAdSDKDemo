//
//  IdProviderFactory.m
//  Demo
//
//  Created by zzq on 2019/12/31.
//  Copyright © 2019 bwhx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSDefaultSet.h"
#import "IdProviderFactory.h"

MSPlatformName const MSPlatformNameMS  = @"meishu";
MSPlatformName const MSPlatformNameBU = @"csj";
MSPlatformName const MSPlatformNameGDT = @"gdt";
MSPlatformName const MSPlatformNameBD  = @"bd";
MSPlatformName const MSPlatformNameDN  = @"dn";

@interface IdProviderFactory ()

@end

@implementation IdProviderFactory

+(IAdIdProvider *) getProvider:(NSString *)platformName {
    return  [[NSClassFromString([MSDefaultSet defaultIdPriders][platformName]) alloc]init];
}

+(NSString *)getPidFor:(MSPlatformName)platformName adType:(MSAdType)adtype{
    return [[self getProvider:platformName]getPidAdType:adtype];
}

+(NSString *)getPidFor:(MSPlatformName)platformName nativeType:(MSNativeAdType)adtype{
    return [[self getProvider:platformName]getPidNativeType:adtype];
}

@end
