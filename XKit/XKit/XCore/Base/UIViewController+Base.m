//
//  UIViewController+Base.m
//  LianghuaJifen
//
//  Created by hjpraul on 16/4/17.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "UIViewController+Base.h"

@implementation UIViewController (Base)
- (void)customViewDidLoad {
    //这个属性属于UIExtendedEdge类型，它可以单独指定矩形的四条边，也可以单独指定、指定全部、全部不指定。
    //指定视图的哪条边需要扩展，不用理会操作栏的透明度。这个属性的默认值是UIRectEdgeAll。
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //如果你使用了不透明的操作栏，设置edgesForExtendedLayout的时候也请将 extendedLayoutIncludesOpaqueBars的值设置为No（默认值是YES）
    self.extendedLayoutIncludesOpaqueBars = NO;
    //如果你不想让scroll view的内容自动调整，将这个属性设为NO（默认值YES）。
    self.automaticallyAdjustsScrollViewInsets = NO;
    //如果navigationbar为不透明的，那么需要这个设置
    self.navigationController.navigationBar.translucent = NO;
    //如果有tabBarController，此设置会在设置了hidesBottomBarWhenPushed的时候让push变得更顺滑。
    self.tabBarController.tabBar.translucent = NO;

//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//    [self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:18],NSFontAttributeName,[UIColor blackColor],NSForegroundColorAttributeName,nil]];
}

// 设置返回键
#define NAV_BAR_ITEM_SPACE  (16)
#define STATUS_BAR_HEIGHT   (20)
#define NAV_BAR_HEIGHT      (44)
- (void)setBackBarVisible:(BOOL)isVisible{
    if (!isVisible) {
        [self.navigationItem setLeftBarButtonItem:nil];
        return;
    }
    UIImage *backBarImg = [UIImage imageNamed:@"icon_nav_back"];
    UIImage *backBarBGImg = [UIImage imageNamed:@"bg_nav_bar_left"];
    CGRect buttonFrame = CGRectMake(0,
                                    STATUS_BAR_HEIGHT/2,
                                    backBarBGImg.size.width+8,
                                    backBarBGImg.size.height);
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = buttonFrame;
    [backButton setAdjustsImageWhenHighlighted:YES];
    [backButton setImage:backBarImg forState:UIControlStateNormal];
    [backButton setBackgroundImage:backBarBGImg forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(bsBackBarClicked) forControlEvents:UIControlEventTouchUpInside];

    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, buttonFrame.size.width, NAV_BAR_HEIGHT)];
    backView.backgroundColor = [UIColor clearColor];
    [backView addSubview:backButton];

    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
    [backBarButtonItem setBackgroundVerticalPositionAdjustment:0.0f forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    flexSpacer.width = -NAV_BAR_ITEM_SPACE;
    [self.navigationItem setLeftBarButtonItems:@[flexSpacer,backBarButtonItem]];
}

// 设置左边按钮
- (UIButton *)setLeftBarByTitle:(NSString *)title
                          image:(UIImage *)image
                         action:(SEL)action {
    UIImage *leftBarBGImg = [UIImage imageNamed:@"bg_nav_bar_left"];
    CGRect buttonFrame = CGRectMake(0,
                                    STATUS_BAR_HEIGHT/2,
                                    leftBarBGImg.size.width+8,
                                    leftBarBGImg.size.height);
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = buttonFrame;
    [leftButton setTitle:title forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    leftButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [leftButton setImage:image forState:UIControlStateNormal];
    [leftButton setBackgroundImage:leftBarBGImg forState:UIControlStateNormal];
    [leftButton setAdjustsImageWhenHighlighted:YES];
    [leftButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, buttonFrame.size.width, NAV_BAR_HEIGHT)];
    leftView.backgroundColor = [UIColor clearColor];
    [leftView addSubview:leftButton];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    [leftBarButtonItem setBackgroundVerticalPositionAdjustment:0.0f forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    flexSpacer.width = -NAV_BAR_ITEM_SPACE;
    [self.navigationItem setLeftBarButtonItems:@[flexSpacer,leftBarButtonItem]];
    
    return leftButton;
}

// 设置右边按钮
- (UIButton *)setRightBarByTitle:(NSString *)title
                           image:(UIImage *)image
                          action:(SEL)action {
    UIImage *barBGImg = [UIImage imageNamed:@"bg_nav_bar_right"];
    CGRect buttonFrame = CGRectMake(0,
                                    STATUS_BAR_HEIGHT/2,
                                    barBGImg.size.width+8,
                                    barBGImg.size.height);
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:buttonFrame];
    [rightButton setTitle:title forState:UIControlStateNormal];
    rightButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [rightButton setImage:image forState:UIControlStateNormal];
    [rightButton setBackgroundImage:barBGImg forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton setAdjustsImageWhenHighlighted:YES];
    [rightButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];

    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, buttonFrame.size.width, NAV_BAR_HEIGHT)];
    rightView.backgroundColor = [UIColor clearColor];
    [rightView addSubview:rightButton];

    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    [rightBarButtonItem setBackgroundVerticalPositionAdjustment:0.0f forBarMetrics:UIBarMetricsDefault];

    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    flexSpacer.width = -NAV_BAR_ITEM_SPACE;
    [self.navigationItem setRightBarButtonItems:@[flexSpacer,rightBarButtonItem]];
    
    return rightButton;
}

#pragma mark - Action Method
- (void)bsBackBarClicked{
    [self.view endEditing:YES];
    if (self.navigationController.viewControllers.count == 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
