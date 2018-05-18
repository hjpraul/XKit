//
//  XBSTableVC.m
//  XKit
//
//  Created by hjpraul on 16/4/17.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "XBSTableVC.h"
#import "UIViewController+XBase.h"

@interface XBSTableVC ()

@end

@implementation XBSTableVC
- (void)viewDidLoad {
    [super viewDidLoad];

    [self customViewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
    [aliPageHitHelper pageAppear:self];
    // 系统返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if ([self.navigationController.viewControllers count] > 1) {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
            self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
        }else{
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航栏下横线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUseCommonBackBar:(BOOL)useCommonBackBar {
    if (useCommonBackBar) {
        [self setBackBarVisible:YES];
    } else {
        [self setBackBarVisible:NO];
    }
}

@end
