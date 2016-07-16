//
//  XRefreshTableView.h
//  DNF
//
//  Created by Jayla on 16/2/3.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XRefreshTableViewDelegate;

@interface XRefreshTableView : UITableView
@property (weak, nonatomic) IBOutlet id<XRefreshTableViewDelegate> refreshDelegate;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) NSUInteger pageSize;
@property (assign, nonatomic) NSUInteger pageIndex;
@property (assign, nonatomic) BOOL loadWithBlank;

@property (strong, nonatomic) NSString *blankTitle;
@property (strong, nonatomic) NSString *blankMessage;

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