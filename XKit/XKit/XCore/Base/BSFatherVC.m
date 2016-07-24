//
//  BSFatherVC.m
//  PalmSchool
//
//  Created by hjpraul on 16/6/11.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "BSFatherVC.h"

@interface BSFatherVC ()
@property (strong, nonatomic) UIView *containerView;  // TODO:这里理论上可以用weak吧？
@end

@implementation BSFatherVC

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

#pragma mark - Public Method
- (void)setChildVcs:(NSArray *)childVcs
      containerView:(UIView *)containerView {
    if (childVcs.count <= 0) {
        return;
    }

    _childVcs = childVcs;
    self.containerView = containerView;
    for (int i = 1; i <= _childVcs.count; i++) {    // 默认第一个为第一选择
        UIViewController *childVc = nil;
        if (i == _childVcs.count) {
            childVc = _childVcs[0];
        } else {
            childVc = _childVcs[i];
        }
        [self addChildViewController:childVc];
        [self.containerView addSubview:childVc.view];
        // 想用autolayout，但是不支持，没法，只能这样了。。。。
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            childVc.view.frame = self.containerView.bounds;
        });
    }
}

- (void)showChildVc:(UIViewController *)childVc {
    if (![_childVcs containsObject:childVc]) {
        // TODO:log
        return;
    }

    UIViewController *toVc = childVc;
    UIViewController *fromVc = nil;
    for (UIViewController *vc in _childVcs) {
        if (vc.view == self.containerView.subviews.lastObject) {
            fromVc = vc;
        }
    }
    if (toVc && fromVc && (fromVc!=toVc)) {
        [self transitionFromViewController:fromVc toViewController:toVc duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut animations:^{
            ;
        } completion:^(BOOL finished) {
            ;// TODO:
        }];
    }
}

- (void)showChildWithIndex:(NSInteger)index {
    if (index >= _childVcs.count) {
        // TODO: log
        return;
    }

    UIViewController *toVc = [_childVcs objectAtIndex:index];
    [self showChildVc:toVc];
}
@end
