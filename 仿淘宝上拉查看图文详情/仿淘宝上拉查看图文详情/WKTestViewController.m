//
//  WKTestViewController.m
//  仿淘宝上拉查看图文详情
//
//  Created by 王昆 on 16/11/7.
//  Copyright © 2016年 wangkun. All rights reserved.
//

#import "WKTestViewController.h"

static CGFloat const WKContentOffSet_Y = 60;
#define KScreen_width [UIScreen mainScreen].bounds.size.width
#define KScreen_height [UIScreen mainScreen].bounds.size.height

@interface WKTestViewController () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;  /**< <#note#> */
@property (nonatomic, strong) UIWebView *webView;  /**< <#note#> */
@property (nonatomic, strong) UILabel *headLabel; /**< <#note#> */
@property (nonatomic, assign) CGFloat contentHeight;  /**< <#note#> */
@end

@implementation WKTestViewController
- (void)dealloc {
    self.webView.scrollView.delegate = nil;
    [self.webView.scrollView removeObserver:self
                                 forKeyPath:@"contentOffset"];
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                            forIndexPath:indexPath];
    cell.textLabel.text   = @"Test";
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if ([scrollView isKindOfClass:[UITableView class]]) {
        CGFloat valueNum   = _tableView.contentSize.height - KScreen_height;
        CGFloat factOffset = offsetY - valueNum;
        if (factOffset > WKContentOffSet_Y) {
            if (!self.contentHeight || self.contentHeight == 0) {
                self.contentHeight = _tableView.contentSize.height;
                [self.view addSubview:self.webView];
            } else {
                [self.view addSubview:self.webView];
                self.webView.frame = CGRectMake(0, KScreen_height - factOffset, KScreen_width, KScreen_height - 64);
            }
            self.tableView.contentSize = CGSizeMake(KScreen_width, self.contentHeight + factOffset);
            [self goToDetailAnimation];
        }
    } else {
        if(offsetY < 0 && -offsetY > WKContentOffSet_Y) {
            
            [self backAnimation]; // 返回基本详情界面的动画
        }
    }
}

#pragma mark - NSKeyValueObserving
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    if(object == _webView.scrollView && [keyPath isEqualToString:@"contentOffset"])
    {
        [self headLabAnimation:[change[@"new"] CGPointValue].y];
    }
}

#pragma mark - private methods
- (void)goToDetailAnimation {
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.webView.frame   = CGRectMake(0, 64, KScreen_width, KScreen_height - 64);
        self.tableView.frame = CGRectMake(0, - KScreen_height, KScreen_width, KScreen_height);
    } completion:^(BOOL finished) {
        self.tableView.contentSize = CGSizeMake(KScreen_width, self.contentHeight);
    }];
}

- (void)backAnimation {
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.webView.frame   = CGRectMake(0, KScreen_height, KScreen_width, KScreen_height - 64);
        self.tableView.frame = CGRectMake(0, 0, KScreen_width, KScreen_height);
    } completion:^(BOOL finished) {
        [self.tableView addSubview:self.webView];
        self.webView.frame = CGRectMake(0, self.contentHeight, KScreen_width, KScreen_height);
    }];
}

- (void)headLabAnimation:(CGFloat)offsetY
{
    _headLabel.alpha  = -offsetY/WKContentOffSet_Y;
    _headLabel.center = CGPointMake(KScreen_width/2, -offsetY/2);
    if(-offsetY > WKContentOffSet_Y) {
        _headLabel.text = @"释放，返回详情";
    } else {
        _headLabel.text = @"上拉，返回详情";
    }
}

#pragma mark - getters
- (UITableView *)tableView
{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreen_width, KScreen_height)
                                                  style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
        _tableView.rowHeight  = 40.f;
        [_tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"cell"];
        
        UILabel *tabFootLab        = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreen_width, 60)];
        tabFootLab.text            = @"继续拖动，查看图文详情";
        tabFootLab.font            = [UIFont systemFontOfSize:13];
        tabFootLab.textAlignment   = NSTextAlignmentCenter;
        _tableView.tableFooterView = tabFootLab;
    }
    return _tableView;
}

- (UIWebView *)webView
{
    if(!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, KScreen_height, KScreen_width, KScreen_height - 64)];
        _webView.scrollView.delegate = self;
        _webView.backgroundColor     = [UIColor whiteColor];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
        [_webView.scrollView addObserver:self
                              forKeyPath:@"contentOffset"
                                 options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                                 context:nil];
        [_webView addSubview:self.headLabel];
    }
    return _webView;
}

- (UILabel *)headLabel
{
    if(!_headLabel){
        _headLabel = [[UILabel alloc] init];
        _headLabel.text          = @"上拉，返回详情";
        _headLabel.textAlignment = NSTextAlignmentCenter;
        _headLabel.font          = [UIFont systemFontOfSize:13];
    }
    _headLabel.frame = CGRectMake(0, 0, KScreen_width, 40.f);
    _headLabel.alpha = 0.f;
    
    return _headLabel;
}
@end
