//
//  MSBaseAdViewController.h
//  MSAdSDKDev
//
//  Created by Liumaos on 2020/7/17.
//  Copyright © 2020 XiXiHaha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IdProviderFactory.h"


NS_ASSUME_NONNULL_BEGIN

@interface MSBaseAdViewController : UIViewController

@property(nonatomic,copy) NSString *defaultPid;
@property(nonatomic,copy) MSPlatformName platform;

@end

NS_ASSUME_NONNULL_END
