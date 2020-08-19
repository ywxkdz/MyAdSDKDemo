//
//  DNViewController.m
//  MSAdSDKDev
//
//  Created by Liumaos on 2020/7/28.
//  Copyright © 2020 Adxdata. All rights reserved.
//

#import "DNViewController.h"

@interface DNViewController ()

@end

@implementation DNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
}

-(void)loadData{
    
    NSMutableArray *marray = [NSMutableArray array];
    [self loadData:marray];
    
}

@end
