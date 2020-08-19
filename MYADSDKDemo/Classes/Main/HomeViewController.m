//
//  MSViewController.m
//  MSAdSDKDev
//
//  Created by Liumaos on 2020/7/15.
//  Copyright © 2020 XiXiHaha. All rights reserved.
//

#import "HomeViewController.h"
#import "MSModuleViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableview;
@property(nonatomic,strong) UIView      *headerView;
@property(nonatomic,strong) NSArray     *dataArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"美数SDK";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableview];
    [self.tableview reloadData];
    
}

#pragma mark-
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    NSDictionary *dict = self.dataArray[indexPath.section];
    
    cell.textLabel.text       = dict[@"title"];
    cell.detailTextLabel.text = dict[@"version"];
    cell.accessoryType        = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle       = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = self.dataArray[indexPath.section];
    
    NSString *vcStr = dict[@"vc"];
    Class cls =  NSClassFromString(vcStr);
    MSModuleViewController *vc =  [[cls alloc]init];
    vc.platformName            =  dict[@"platform"];
    vc.title                   = dict[@"title"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(UITableView *)tableview{
    
    if (!_tableview) {
        
        CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 0);
        _tableview = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}


-(NSArray *)dataArray{
    
    
    if (!_dataArray) {
        _dataArray = @[
            @{
                @"title":@"美数",
                @"version":[MSAdSDK platformVersion:MSShowTypeMS]?:@"未安装",
                @"vc":@"MSViewController",
                @"platform":MSPlatformNameMS
            },
            @{
                @"title":@"广点通",
                @"version":[MSAdSDK platformVersion:MSShowTypeGDT]?:@"未安装",
                @"vc":@"GDTViewController",
                @"platform":MSPlatformNameGDT
            },
            @{
                @"title":@"穿山甲",
                @"version":[MSAdSDK platformVersion:MSShowTypeBU]?:@"未安装",
                @"vc":@"BUViewController",
                @"platform":MSPlatformNameBU
            },
            @{
                @"title":@"百度",
                @"version":[MSAdSDK platformVersion:MSShowTypeBD]?:@"未安装",
                @"vc":@"BDViewController",
                @"platform":MSPlatformNameBD
            },
            @{
                @"title":@"多牛",
                @"version":[MSAdSDK platformVersion:MSShowTypeDN]?:@"未安装",
                @"vc":@"DNViewController",
                @"platform":MSPlatformNameDN
            }
        ];
    }
    return _dataArray;
}



@end
