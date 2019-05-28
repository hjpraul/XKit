//
//  DemoHomeVC.m
//  XKit
//
//  Created by hjpraul on 16/7/18.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "DemoHomeVC.h"
#import "TestLoadingVC.h"

@interface DemoHomeVC ()

@end

@implementation DemoHomeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
            UINavigationController *nav = [[UIStoryboard storyboardWithName:@"TestLoading" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        }break;
        case 2:{
            UINavigationController *nav = [[UIStoryboard storyboardWithName:@"TestButtons" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        }break;

        default:
            break;
    }
}

@end
