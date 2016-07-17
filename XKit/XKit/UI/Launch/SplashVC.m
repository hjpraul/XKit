//
//  SplashVC.m
//  XKit
//
//  Created by hjpraul on 16/7/18.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "SplashVC.h"

@interface SplashVC ()

@end

@implementation SplashVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self enterHome];
    });
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
- (void)enterHome {
    [UIView transitionWithView:[UIApplication sharedApplication].delegate.window duration:0.6 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        BOOL oldState=[UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].delegate.window.rootViewController = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]].instantiateInitialViewController;
        [UIView setAnimationsEnabled:oldState];
    } completion:^(BOOL finished) {
        ; // do nothing
    }];
}
@end
