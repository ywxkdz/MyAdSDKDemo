//
//  MSNativeViewController.m
//  MSAdSDKDev
//
//  Created by Liumaos on 2020/7/30.
//  Copyright © 2020 Adxdata. All rights reserved.
//

#import "MSFeedViewController.h"
#import "IdProviderFactory.h"
#import "MSFeedListViewController.h"

@interface MSFeedViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableview;
@property(nonatomic,strong) NSArray     *dataArray;

@end

@implementation MSFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableview];
    [self.tableview reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    NSDictionary *dict = self.dataArray[indexPath.section];
    cell.textLabel.text       = dict[@"title"];
    cell.detailTextLabel.text = dict[@"pid"];
    cell.accessoryType        = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle       = UITableViewCellSelectionStyleNone;
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MSFeedListViewController *vc = [MSFeedListViewController new];
    
    NSDictionary *dict = self.dataArray[indexPath.section];
    vc.pid = dict[@"pid"];
    vc.showType = [dict[@"type"] integerValue];
    [self.navigationController pushViewController:vc animated:YES];

}



-(UITableView *)tableview{
    
    if (!_tableview) {
        CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        _tableview = [[UITableView alloc]initWithFrame:frame
                                                 style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}

-(NSArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = @[
            @{
                @"title":@"左图右文字带按钮",
                @"type":@(MSNativeAdLeftImage),
                @"pid":[IdProviderFactory getPidFor:self.platform
                                         nativeType:MSNativeAdLeftImage]
            },
            @{
                @"title":@"左图右文字",
                @"type":@(MSNativeAdLeftImageNoButton),
                @"pid":[IdProviderFactory getPidFor:self.platform nativeType:MSNativeAdLeftImageNoButton]
                
            },
            @{
                @"title":@"上文字下图",
                @"type":@(MSNativeAdBottomImage),
                @"pid":[IdProviderFactory getPidFor:self.platform
                                         nativeType:MSNativeAdBottomImage]
                
            },
            @{
                @"title":@"上文字下三图",
                @"type":@(MSNativeAdThreeImage),
                @"pid":[IdProviderFactory getPidFor:self.platform
                                         nativeType:MSNativeAdThreeImage]
                
            },
            @{
                @"title":@"上文字下视频",
                @"type":@(    MSNativeAdVideo),
                @"pid":[IdProviderFactory getPidFor:self.platform
                                         nativeType:MSNativeAdVideo]
                
            }
        ];
    }
    return _dataArray;
}

@end
