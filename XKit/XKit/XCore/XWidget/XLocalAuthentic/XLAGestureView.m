//
//  XLAGestureView.m
//  AnXinFu
//
//  Created by DaanTsai on 2018/1/5.
//  Copyright © 2018年 hjpraul. All rights reserved.
//

#define kButtonWidth    74.0f
#define kButtonHeight   74.0f
#define kLineColorNormal      RGB(33, 138, 241)
#define kLineColorError       RGB(255, 72, 124)

#import "XLAGestureView.h"
#import "UIImage+XCreate.h"

@interface XLAGestureView()
@property (strong, nonatomic) UIColor *lineColor;
@property (strong, nonatomic) NSMutableArray *buttons;
@property (assign, nonatomic) CGPoint currentPoint;
@property (strong, nonatomic) NSMutableString *password;
@end

@implementation XLAGestureView

- (void)initPoints {
    for (int i=0; i<9; i++) {
        self.lineColor = kLineColorNormal;
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_gesture_password_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_gesture_password_selected"] forState:UIControlStateHighlighted ];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_gesture_password_error"] forState:UIControlStateDisabled];
        btn.tag = i;
        [self addSubview:btn];
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initPoints];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initPoints];
    }
    return self;
}

- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)drawRect:(CGRect)rect {
    if (self.buttons.count == 0 ) {
        return;
    }
    // 创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 遍历所有按钮进行绘制
    [self.buttons enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 第一个按钮，中心点就是起点 
        if (idx == 0) {
            [path moveToPoint:obj.center];
        } else {
            [path addLineToPoint:obj.center];
        }
    }];
    [path addLineToPoint:self.currentPoint];
    // 设置路径属性
    path.lineWidth = 5;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    [self.lineColor setStroke];
    // 渲染
    [path stroke];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat Margin = (self.bounds.size.width - 3 * kButtonWidth) / 2;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        int row = (int)idx / 3;
        int col = idx % 3;
        obj.frame = CGRectMake(col * (Margin + kButtonWidth), row * (Margin + kButtonHeight), kButtonWidth, kButtonHeight);
    }];
}

#pragma mark - touch event observe
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_isForbidden) {
        return;
    }
    UITouch *touch = touches.anyObject;
    CGPoint loc = [touch locationInView:self];
    self.currentPoint = loc;
    // 遍历按钮，判定触摸点是否在按钮上
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isContains = CGRectContainsPoint(obj.frame, loc);
        // 如果在按钮上，将当前按钮保存在数组中，并改变按钮状态
        if (isContains&&obj.highlighted == NO) {
            [self.buttons addObject:obj];
            obj.highlighted = YES;
        } else {
            obj.highlighted = NO;
        }
    }];
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_isForbidden) {
        return;
    }
    UITouch *touch = touches.anyObject;
    CGPoint loc = [touch locationInView:self];
    self.currentPoint = loc;
    // 遍历按钮，如果按钮在滑动路径上，就改变按钮状态
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isContains = CGRectContainsPoint(obj.frame, loc);
        if (isContains&&obj.highlighted == NO) {
            [self.buttons addObject:obj];
            obj.highlighted = YES;
        }
    }];
    // 重绘
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_isForbidden) {
        return;
    }
    self.userInteractionEnabled = NO;
    self.currentPoint = [(UIButton *)self.buttons.lastObject center];
    [self setNeedsDisplay];         // 重绘
    self.password = [NSMutableString string];     // 判定密码
    [self.buttons enumerateObjectsUsingBlock:^( UIButton *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.password appendFormat:@"%@",@(obj.tag)];
    }];
    BOOL isOk = YES;
    if (_passwordFinishedBlock) {
        isOk = _passwordFinishedBlock(_password);
    }
    if (isOk) {
        [self.buttons enumerateObjectsUsingBlock:^(UIButton*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.highlighted = NO;
        }];
        [self.buttons removeAllObjects];
        [self setNeedsDisplay];
        self.userInteractionEnabled = YES;
    } else {
        [self.buttons enumerateObjectsUsingBlock:^(UIButton *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            self.lineColor = kLineColorError;
            obj.highlighted = NO;
            obj.enabled = NO;
        }];
        [self setNeedsDisplay];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 回复按钮状态
            [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.enabled = YES;
            }];
            // 恢复线条的颜色
            self.lineColor = kLineColorNormal;
            [self.buttons removeAllObjects];
            [self setNeedsDisplay];
            self.userInteractionEnabled = YES;
        });
    }
}
@end
