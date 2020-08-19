//
//  MSBaseViewController.m
//  MSAdSDKDev
//
//  Created by Liumaos on 2020/7/17.
//  Copyright © 2020 XiXiHaha. All rights reserved.
//

#import "MSModuleViewController.h"
#import "MSBaseAdViewController.h"
@interface MSModuleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableview;
@property(nonatomic,strong) NSMutableArray<MSPidModel*> *dataArray;


@end

@implementation MSModuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData:[self defaultArray]];
    
    [self.view addSubview:self.tableview];
    [self.tableview reloadData];
}


-(void)loadData:(NSMutableArray<MSPidModel *> *)dataArray{
    
    if (self.dataArray == nil) {
        self.dataArray  = dataArray;
    }else{
        [self.dataArray addObjectsFromArray:dataArray];
    }
    [self.tableview reloadData];
}

-(NSMutableArray*)defaultArray{
    
    NSMutableArray *marray = [NSMutableArray array];
    
    [marray addObject:[MSPidModel modelIn:self.platformName adtype:MSAdTypeSplash]];
    [marray addObject:[MSPidModel modelIn:self.platformName adtype:MSAdTypeBanner]];
    [marray addObject:[MSPidModel modelIn:self.platformName adtype:MSAdTypeReward]];
    [marray addObject:[MSPidModel modelIn:self.platformName adtype:MSAdTypeInterstitial]];
    [marray addObject:[MSPidModel modelIn:self.platformName adtype:MSAdTypeVideoAd]];
    [marray addObject:[MSPidModel modelIn:self.platformName adtype:MSAdTypeFeedPreRender]];
    [marray addObject:[MSPidModel modelIn:self.platformName adtype:MSAdTypeFeed]];
    
    return marray;
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
    MSPidModel *model = self.dataArray[indexPath.section];
    cell.textLabel.text       = model.moduleName;
    cell.detailTextLabel.text = model.pid;
    cell.accessoryType        = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle       = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MSPidModel *model    =  self.dataArray[indexPath.section];
    
    Class cls = NSClassFromString(model.vc);
    MSBaseAdViewController *vc = [[cls alloc]init];
    
    vc.defaultPid        = model.pid;
    vc.title             = model.moduleName;
    vc.platform          = self.platformName;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(UITableView *)tableview{
    
    if (!_tableview) {
        
        CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 0);
        _tableview = [[UITableView alloc]initWithFrame:frame
                                                 style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}
@end
