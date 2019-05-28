//
//  UIViewController+XBase.m
//  XKit
//
//  Created by hjpraul on 16/4/17.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#import "UIViewController+XBase.h"
#import "UIImage+XCreate.h"

@implementation UIViewController (XBase)
#pragma mark - Public Method
- (UIBarButtonItem *)creatBarItemByTitle:(NSString *)title
                                   image:(UIImage *)image
                                 bgImage:(UIImage *)bgImage
                                    size:(CGSize)size
                                  action:(SEL)action
                                  button:(UIButton **)button {
    CGRect frame = CGRectMake(0,0,size.width,size.height);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [btn setImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:bgImage forState:UIControlStateNormal];
    [btn setAdjustsImageWhenHighlighted:YES];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    if (button) {
        *button = btn;
    }

    UIView *barView = [[UIView alloc] initWithFrame:frame];
    barView.backgroundColor = [UIColor clearColor];
    [barView addSubview:btn];

    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:barView];
    [barItem setBackgroundVerticalPositionAdjustment:0.0f forBarMetrics:UIBarMetricsDefault];

    return barItem;
}

- (UIButton *)setLeftBarByTitle:(NSString *)title
                          image:(UIImage *)image
                        bgImage:(UIImage *)bgImage
                     leftOffset:(CGFloat)leftOffset
                           size:(CGSize)size
                         action:(SEL)action {
    UIButton *btn = nil;
    UIBarButtonItem *barItem = [self creatBarItemByTitle:title
                                                   image:image
                                                 bgImage:bgImage
                                                    size:size
                                                  action:action
                                                  button:&btn];
    if (leftOffset != 0) {
        UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        flexSpacer.width = leftOffset;
        [self.navigationItem setLeftBarButtonItems:@[flexSpacer,barItem]];
    } else {
        [self.navigationItem setLeftBarButtonItems:@[barItem]];
    }
    if ([XUtil systemMainVersion] >= 11) {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    
    return btn;
}

- (UIButton *)setRightBarByTitle:(NSString *)title
                           image:(UIImage *)image
                         bgImage:(UIImage *)bgImage
                     rightOffset:(CGFloat)rightOffset
                            size:(CGSize)size
                          action:(SEL)action {
    UIButton *btn = nil;
    UIBarButtonItem *barItem = [self creatBarItemByTitle:title
                                                   image:image
                                                 bgImage:bgImage
                                                    size:size
                                                  action:action
                                                  button:&btn];
    if (rightOffset != 0) {
        UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        flexSpacer.width = rightOffset;
        [self.navigationItem setRightBarButtonItems:@[flexSpacer,barItem]];
    } else {
        [self.navigationItem setRightBarButtonItems:@[barItem]];
    }
    if ([XUtil systemMainVersion] >= 11) {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }

    return btn;
}

- (void)defaultBackBarAction {
    [self.view endEditing:YES];
    if (self.navigationController.viewControllers.count == 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setNavigationBarTransparent:(BOOL)isTransparent {
    if (isTransparent) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
        self.navigationController.navigationBar.translucent = YES;
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage x_imageWithColor:[UIColor clearColor] size:CGSizeMake(20, 20)] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forBarMetrics:UIBarMetricsDefault];
    } else {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
        UIImage *tempNavBg = [UIImage x_imageWithColor:RGB(33, 138, 238) size:self.view.bounds.size];
        [self.navigationController.navigationBar setBackgroundImage:tempNavBg forBarMetrics:UIBarMetricsDefault];
    }
}

#pragma mark - Customer Setting (in this project)
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

    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:18],NSFontAttributeName,[UIColor blackColor],NSForegroundColorAttributeName,nil]];
}

- (void)setBackBarVisible:(BOOL)isVisible{
    if (!isVisible) {
//        [self.navigationItem setLeftBarButtonItem:nil];
        [self setLeftBarByTitle:nil
                          image:nil
                        bgImage:nil
                     leftOffset:-16.0f
                           size:CGSizeMake(44, 44)
                         action:nil];
        return;
    }

    [self setLeftBarByTitle:nil
                      image:[UIImage x_imageWithColor:[UIColor redColor] size:CGSizeMake(20, 20)]//[UIImage imageNamed:@"nav_back_white"]
                    bgImage:nil
                 leftOffset:-16.0f
                       size:CGSizeMake(44, 44)
                     action:@selector(defaultBackBarAction)];
}

@end
