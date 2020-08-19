//
//  MSPreRenderViewController.m
//  MSAdSDKDev
//
//  Created by Liumaos on 2020/8/3.
//  Copyright © 2020 Adxdata. All rights reserved.
//

#import "MSPreRenderViewController.h"
#import "MSPrerenderCell.h"


@interface MSPreRenderViewController ()<MSPrerenderAdDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)MSPrerenderAd *  prerenderAd;

@property(nonatomic,strong) NSArray *dataArray;

@property (strong, nonatomic)  UITextField *defaultPidTF;
@property (strong, nonatomic)  UIButton    *refreshBtn;
@property (strong, nonatomic)  UITableView *tableview;

@end

@implementation MSPreRenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    self.defaultPidTF.text    = self.defaultPid;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    for (int index=0; index<self.dataArray.count; index++) {
        UIView *obj = self.dataArray[index];
        height+=obj.frame.size.height;
    }
    return height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MSPrerenderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MSPrerenderCell"
                                                            forIndexPath:indexPath];
    UIView *adView = self.dataArray[indexPath.row];
    
    [cell updateCell:adView];
    return cell;
}

- (void)refreshAd:(UIButton *)sender {
    
    NSString *pid = self.defaultPidTF.text.length ? self.defaultPidTF.text : self.defaultPid;
    MSPrerenderAd *  prerenderAd = [[MSPrerenderAd alloc]initWithCurController:self];
    self.prerenderAd = prerenderAd;
    prerenderAd.delegate = self;
    
    [prerenderAd loadAd:pid];
    
}

#pragma mark- Delegate

- (void)msPrerenderLoaded:(MSPrerenderAd *)prerenderAd
              adViewArray:(NSArray *)adViewArray{
    
    self.dataArray = adViewArray;
    [self.tableview reloadData];
    
}

- (void)msPrerenderError:(MSPrerenderAd *)prerenderAd
                   error:(NSError *)error{
    
}

- (void)msPrerenderRenderSuccess:(UIView *)adView {
    
}

- (void)msPrerenderRenderError:(UIView *)adView error:(NSError *)error{
    
    
}

-(void)msPrerenderPlatformError:(MSShowType)platform
                             ad:(MSPrerenderAd *)prerenderAd
                          error:(NSError *)error{
    
}

- (void)msPrerenderShow:(UIView *)adView{
    
}

- (void)msPrerenderClicked:(UIView *)adView{
    
}


- (void)msPrerenderClosed:(UIView *)adView{
    self.dataArray = nil;
    [self.tableview reloadData];
}



#pragma mark - SetUpView

-(void) setUpView{
    
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableview.delegate   = self;
    tableview.dataSource = self;
    [tableview registerClass:[MSPrerenderCell class] forCellReuseIdentifier:@"MSPrerenderCell"];
    self.tableview = tableview;
    [self.view addSubview:self.tableview];
    
    
    self.defaultPidTF = [MSQuickCreate defaultPidTextField];
    [self.view addSubview:self.defaultPidTF];
    
    UIButton * loadBtn = [MSQuickCreate longActionBtn];
    [loadBtn setTitle:@"刷新广告" forState:UIControlStateNormal];
    [loadBtn addTarget:self
                action:@selector(refreshAd:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadBtn];
    
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.leading.trailing.offset(0);
        make.bottom.equalTo(self.defaultPidTF.mas_top).offset(-20);
    }];
    
    [self.defaultPidTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@48);
        make.leading.offset(20);
        make.trailing.offset(-20);
    }];
    
    [loadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@48);
        make.leading.offset(20);
        make.trailing.offset(-20);
        make.bottom.offset(-60);
        make.top.equalTo(self.defaultPidTF.mas_bottom).offset(20);
        
    }];
}


@end
