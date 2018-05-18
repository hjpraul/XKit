//
//  XRefreshTableView.h
//  XKit
//
//  Created by hjpraul on 16/7/18.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XRefreshTableViewDelegate;

@interface XRefreshTableView : UITableView
@property (weak, nonatomic) IBOutlet id<XRefreshTableViewDelegate> refreshDelegate;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) NSUInteger pageSize;  // 0 表示不分页
@property (assign, nonatomic) NSUInteger pageIndex;

@property (assign, nonatomic) BOOL loadWithBlank;
@property (strong, nonatomic) NSString *emptyMessage;

- (void)refreshData;
@end

@protocol XRefreshTableViewDelegate <NSObject>
@optional
- (void)tableView:(XRefreshTableView *)tableView
         pageSize:(NSUInteger)pageSize
        pageIndex:(NSUInteger)pageIndex
          success:(void (^)(NSArray *list))success
          failure:(void (^)(NSError *error))failure;

@end