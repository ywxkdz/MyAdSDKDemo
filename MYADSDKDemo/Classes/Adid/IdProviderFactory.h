//
//  IdProviderFactory.h
//  Demo
//
//  Created by zzq on 2019/12/31.
//  Copyright © 2019 bwhx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAdIdProvider.h"
#import "BDIdProvider.h"
#import "MSIdProvider.h"
#import "BUIdProvider.h"
#import "GDTIdProvider.h"
#import "DNAdIdProvider.h"

typedef NSString * MSPlatformName;

extern MSPlatformName const _Nonnull MSPlatformNameMS;
extern MSPlatformName const _Nonnull MSPlatformNameBU;
extern MSPlatformName const _Nonnull MSPlatformNameGDT;
extern MSPlatformName const _Nonnull MSPlatformNameBD;
extern MSPlatformName const _Nonnull MSPlatformNameDN;

@interface IdProviderFactory : NSObject

+(IAdIdProvider * _Nonnull)  getProvider:(NSString * _Nonnull) platformName;

+(NSString *_Nonnull) getPidFor:(MSPlatformName _Nonnull ) platformName
                         adType:(MSAdType)adtype;

+(NSString *_Nonnull) getPidFor:(MSPlatformName)platformName
                     nativeType:(MSNativeAdType)adtype;


@end
