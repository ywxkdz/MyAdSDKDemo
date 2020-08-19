//
//  MSFeedListViewController.m
//  MSAdSDKDev
//
//  Created by Liumaos on 2020/7/30.
//  Copyright © 2020 Adxdata. All rights reserved.
//

#import "MSFeedListViewController.h"
#import "IdProviderFactory.h"
#import "FeedVideoView.h"

@interface MSFeedListViewController ()<MSNativeAdDelegate,UITableViewDelegate,UITableViewDataSource,MSNativeAdDelegate>

@property(nonatomic,strong) MSNativeAd *nativeAd;
@property (nonatomic, strong) NSMutableArray *expressAdViews;
@property (nonatomic, strong) NSMutableArray *datas;
@property (assign, nonatomic) CGFloat height1;
@property (assign, nonatomic) CGFloat height2;
@property (assign, nonatomic) CGFloat height3;
@property (assign, nonatomic) CGFloat heightThreeImage;
@property (assign, nonatomic) CGFloat heightVideo;
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation MSFeedListViewController

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (NSMutableArray *)expressAdViews{
    if (!_expressAdViews) {
        _expressAdViews = [NSMutableArray array];
    }
    return _expressAdViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"nativeexpresscell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"testdatacell"];
    self.nativeAd = [[MSNativeAd alloc]initWithCurController:self];
    self.nativeAd.delegate = self;
    [self.nativeAd loadAd:3 pid:_pid];
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.expressAdViews[indexPath.row] isKindOfClass:[NSString class]]) {
        return 70;
    }
    if (self.showType == MSNativeAdLeftImage) {
        return self.height1;
    } else if (self.showType == MSNativeAdLeftImageNoButton){
        return self.height2;
    } else if (self.showType == MSNativeAdBottomImage){
        return self.height3;
    } else if (self.showType == MSNativeAdThreeImage) {
        return self.heightThreeImage;
    } else if (self.showType == MSNativeAdVideo) {
        return self.heightVideo;
    }
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.expressAdViews.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.expressAdViews[indexPath.row] isKindOfClass:[NSString class]]) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: @"testdatacell"
                                                                 forIndexPath:indexPath];
        NSString *data = self.expressAdViews[indexPath.row];
        [cell.textLabel setText:data];
        return cell;
    }
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: @"nativeexpresscell"
                                                             forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1
                                      reuseIdentifier: @"nativeexpresscell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    id<MSFeedAdMeta> data = self.expressAdViews[indexPath.row];
    if (data.metaCreative_type == MSCreativeTypeVideo) {
        FeedVideoView *ativeAdView = [[FeedVideoView alloc]initWithWidth:self.view.frame.size.width adModel:data];
        [cell addSubview:ativeAdView];
        //要加载的数据
        MSFeedVideoView *mediaView = [data registerMediaView:[ativeAdView getMediaViewContainer] clickView:ativeAdView vc:self];
        ativeAdView.mediaView = mediaView;
        mediaView.delegate = ativeAdView;
//        [self.nativeAd attachAd:model toView:ativeAdView];
    } else {
        MSNativeAdView *ativeAdView = [[MSNativeAdView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100) adModel:data];

        ativeAdView.nativeAdViewShowType = self.showType;

        [cell addSubview:ativeAdView];
        //要加载的数据
        [data attachAd:ativeAdView];
    }
    cell.userInteractionEnabled = YES;
    cell.accessibilityIdentifier = @"nativeTemp_ad";
    return cell;
}

-(void) loadData{
    
    self.nativeAd = [[MSNativeAd alloc]initWithCurController:self];
    self.nativeAd.delegate = self;
    [self.nativeAd loadAd:3 pid:self.pid];
    
}

#pragma mark- Delegate

- (void)msNativeLoaded:(NSArray<MSFeedAdMeta> *)nativeAdDataArray{
    
        MSWS(ws);
        if (nativeAdDataArray.count > 0) {
            [ws.tableView beginUpdates];
            NSInteger count = ws.expressAdViews.count;

            id<MSFeedAdMeta>data = nativeAdDataArray[0];
            if (data.metaCreative_type != MSCreativeTypeVideo) {
                CGFloat tmp = [MSNativeAdView heightCellForRow:data nativeAdViewShowType:ws.showType];
                if (ws.showType == MSNativeAdLeftImage) {
                    ws.height1 = tmp;
                } else if (ws.showType == MSNativeAdLeftImageNoButton) {
                    ws.height2 = tmp;
                } else if (ws.showType == MSNativeAdBottomImage) {
                    ws.height3 = tmp;
                } else if (ws.showType == MSNativeAdThreeImage) {
                    ws.heightThreeImage = tmp;
                }
            } else {
                ws.heightVideo = [FeedVideoView heightCellForRow:data width:self.view.frame.size.width];
                
            }

            NSMutableArray<NSIndexPath *> *paths = [NSMutableArray new];
            [ws.expressAdViews addObjectsFromArray:nativeAdDataArray];

            for (NSInteger i = 0; i < nativeAdDataArray.count; i++) {
                [paths addObject:[NSIndexPath indexPathForItem:(count + i) inSection:0]];
            }
            count += nativeAdDataArray.count;

            for (NSInteger i = 0; i < 10; i++) {
    //            [ws.expressAdViews addObject:[[NSString alloc] initWithFormat:@"测试数据 %d" arguments:ws.expressAdViews.count]];
                [ws.expressAdViews addObject:@"测试数据"];
                [paths addObject:[NSIndexPath indexPathForItem:(count + i) inSection:0]];
            }
            [ws.tableView insertRowsAtIndexPaths:paths withRowAnimation:false];

            [ws.tableView endUpdates];
        }
}

- (void)msNativeError:(NSError *)error{
    
}

-(void)msNativePlatformError:(MSShowType)platform
                       error:(NSError *)error{
    
}

- (void)msNativeShow:(MSFeedAdData *)feedAdData{
    
}

- (void)msNativeClick:(MSFeedAdData *)feedAdData{
    
}


- (void)msNativeDetailShow{
    
}

- (void)msNativeDetailClosed{
    
}

@end
