//
//  TestLoadingVC.m
//  XKit
//
//  Created by hjpraul on 16/7/18.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "TestLoadingVC.h"

@interface TestLoadingVC ()

@end

@implementation TestLoadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            [@"测试toast" x_toast];
        }break;
        case 1:{
            [self showLoadingWithMessage:@"加载中..."];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self showSuccessWithMessage:@"加载成功"];
            });
        }break;
        case 2:{
            [self.tableView showBlankWithType:kBlankTypeLoading message:@"加载中..." action:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView showBlankWithImage:nil message:@"加载完成加载完成加载完成加载完成加载完成加载完成加载完成加载完成" action:^{
                    [@"你点我做甚！！" x_toast];
                }];
            });
        }break;

        default:
            break;
    }
}

@end
