//
//  XRefreshCollectionView.h
//  XKit
//
//  Created by hjpraul on 16/7/18.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XRefreshCollectionViewDelegate;

@interface XRefreshCollectionView : UICollectionView
@property (weak, nonatomic) IBOutlet id<XRefreshCollectionViewDelegate> refreshDelegate;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) NSUInteger pageSize;
@property (assign, nonatomic) NSUInteger pageIndex;

@property (assign, nonatomic) BOOL loadWithBlank;
@property (strong, nonatomic) NSString *emptyMessage;

- (void)refreshData;
@end

@protocol XRefreshCollectionViewDelegate <NSObject>
@optional
- (void)collectionView:(XRefreshCollectionView *)collectionView
              pageSize:(NSUInteger)pageSize
             pageIndex:(NSUInteger)pageIndex
               success:(void (^)(NSArray *list))success
               failure:(void (^)(NSError *error))failure;

@end
