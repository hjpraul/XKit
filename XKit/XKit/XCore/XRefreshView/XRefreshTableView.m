//
//  XRefreshTableView.m
//  XKit
//
//  Created by hjpraul on 16/7/18.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "XRefreshTableView.h"
#import "UIView+XBlank.h"

@interface XRefreshTableView ()

@end

@implementation XRefreshTableView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    self.pageSize = 10;
    self.pageIndex = 0;
    self.loadWithBlank = YES;
    self.emptyMessage = @"无数据";
}

- (void)setRefreshDelegate:(id<XRefreshTableViewDelegate>)refreshDelegate {
    _refreshDelegate = refreshDelegate;
    
    if ([self.refreshDelegate respondsToSelector:@selector(tableView:pageSize:pageIndex:success:failure:)]) {
        [self addRefreshHeader];
    }
}

/**********************************************************************/
#pragma mark - Private
/**********************************************************************/

- (void)addRefreshHeader {
    if (self.mj_header) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSUInteger pageIndex = 0;
        [self.refreshDelegate tableView:weakSelf pageSize:weakSelf.pageSize pageIndex:pageIndex success:^(NSArray *list) {
            weakSelf.pageIndex = pageIndex;
            [weakSelf.mj_header endRefreshing];
            weakSelf.dataArray = [list mutableCopy];
            [weakSelf reloadData];
            
            [weakSelf addRefreshFooter];
            if (list.count < weakSelf.pageSize) {
                [weakSelf.mj_footer endRefreshingWithNoMoreData];
            } else {
                [weakSelf.mj_footer endRefreshing];
            }
            
            if (weakSelf.dataArray.count==0) {
                weakSelf.mj_footer.hidden = YES;
                [weakSelf showBlankWithType:kBlankTypeNoInfo message:weakSelf.emptyMessage action:^{
                    [weakSelf refreshData];
                }];
            } else {
                weakSelf.mj_footer.hidden = NO;
                [weakSelf dismissBlank];
            }
        } failure:^(NSError *error) {
            [weakSelf.mj_header endRefreshing];
            
            NSString *message = error.localizedDescription?:weakSelf.emptyMessage;
            if (weakSelf.dataArray.count==0) {
                weakSelf.mj_footer.hidden = YES;
                [weakSelf showBlankWithType:kBlankTypeFailed message:message action:^{
                    [weakSelf refreshData];
                }];
            } else {
                weakSelf.mj_footer.hidden = NO;
                [weakSelf dismissBlank];
                [message x_toast];
            }
        }];
    }];
    self.mj_header = header;
}

- (void)addRefreshFooter {
    if (self.mj_footer) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSUInteger pageIndex = weakSelf.pageIndex + 1;
        [self.refreshDelegate tableView:weakSelf pageSize:weakSelf.pageSize pageIndex:pageIndex success:^(NSArray *list) {
            weakSelf.pageIndex = pageIndex;
            [weakSelf.mj_footer endRefreshing];
            [weakSelf.dataArray addObjectsFromArray:list];
            [weakSelf reloadData];
            
            if (list.count < weakSelf.pageSize) {
                [weakSelf.mj_footer endRefreshingWithNoMoreData];
            } else {
                [weakSelf.mj_footer endRefreshing];
            }
            
            if (weakSelf.dataArray.count==0) {
                weakSelf.mj_footer.hidden = YES;
                [weakSelf showBlankWithType:kBlankTypeNoInfo message:weakSelf.emptyMessage action:^{
                    [weakSelf refreshData];
                }];
            } else {
                weakSelf.mj_footer.hidden = NO;
                [weakSelf dismissBlank];
            }
        } failure:^(NSError *error) {
            [weakSelf.mj_footer endRefreshing];
            
            NSString *message = error.localizedDescription?:weakSelf.emptyMessage;
            if (weakSelf.dataArray.count==0) {
                weakSelf.mj_footer.hidden = YES;
                [weakSelf showBlankWithType:kBlankTypeNoInfo message:message action:^{
                    [weakSelf refreshData];
                }];
            } else {
                weakSelf.mj_footer.hidden = NO;
                [weakSelf dismissBlank];
                [message x_toast];
            }
        }];
    }];
    self.mj_footer = footer;
}

/**********************************************************************/
#pragma mark - Public
/**********************************************************************/

- (void)refreshData {
    if (self.loadWithBlank) {
        BLOCK_SAFE(self.mj_header.refreshingBlock)();
    } else {
        [self.mj_header beginRefreshing];
    }
}

@end
