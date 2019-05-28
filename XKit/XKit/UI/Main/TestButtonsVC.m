//
//  TestButtonsVC.m
//  
//
//  Created by hjpraul on 2018/11/6.
//

#import "TestButtonsVC.h"

@interface TestButtonsVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *updownBtnHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *updownBtnWidth;

@end

@implementation TestButtonsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _updownBtnWidth.constant = 220;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.updownBtnHeight.constant = 120;
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
