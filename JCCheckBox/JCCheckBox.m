//
//  JCCheckBox.m
//  JCCheckBox
//
//  Created by Juncheng Han on 10/22/18.
//  Copyright © 2018 Jason H. All rights reserved.
//

#define DEFAULT_HEIGHT 24.0f
#define DEFAULT_WIDTH 24.0f

#import "JCCheckBox.h"

@interface JCCheckBox ()

@property (strong, nonatomic) CAShapeLayer *outerLayer;
@property (strong, nonatomic) CAShapeLayer *innerLayer;

@property (assign, nonatomic) BOOL alert;

@end

@implementation JCCheckBox

- (void)dealloc {
    _checkedCompletion = nil;
    _uncheckedCompletion = nil;
    [_outerLayer removeAllAnimations];
    [_innerLayer removeAllAnimations];
    _outerLayer = nil;
    _innerLayer = nil;
}

+ (instancetype)checkBox {
    return [[self alloc] initWithFrame:CGRectMake(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpDefaults];
        [self setUpLayers];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpDefaults];
        [self setUpLayers];
    }
    return self;
}

- (void)setUpDefaults {
    // default
    self.selected = false;
    self.backgroundColor = [UIColor clearColor];
    _alert = false;
    _checkBoxStyle = JCCheckBoxStyleSquare;
    _outerColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:1 alpha:1];
    _innerColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:1 alpha:1];;
    _alartColor = [UIColor redColor];
    
    _checkedCompletion = nil;
    _uncheckedCompletion = nil;
}

- (void)setUpLayers {
    
    [_outerLayer removeFromSuperlayer];
    _outerLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_outerLayer];
    _outerLayer.frame = CGRectMake(0.08333 *  CGRectGetWidth(_outerLayer.superlayer.bounds), 0.08333 * CGRectGetHeight(_outerLayer.superlayer.bounds), 0.83333 * CGRectGetWidth(_outerLayer.superlayer.bounds), 0.83333 * CGRectGetHeight(_outerLayer.superlayer.bounds));
    _outerLayer.path = [self getPath:[_outerLayer bounds]].CGPath;
    _outerLayer.fillColor = [UIColor clearColor].CGColor;
    _outerLayer.strokeColor = self.outerColor.CGColor;
    _outerLayer.lineWidth = 2;
    
    [_innerLayer removeFromSuperlayer];
    _innerLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_innerLayer];
    _innerLayer.frame = CGRectMake(0.25 * CGRectGetWidth(_innerLayer.superlayer.bounds), 0.25 * CGRectGetHeight(_innerLayer.superlayer.bounds), 0.5 * CGRectGetWidth(_innerLayer.superlayer.bounds), 0.5 * CGRectGetHeight(_innerLayer.superlayer.bounds));
    _innerLayer.path = [self getPath:[_innerLayer bounds]].CGPath;
    _innerLayer.fillColor = self.innerColor.CGColor;
    _innerLayer.strokeColor = self.innerColor.CGColor;
    _innerLayer.lineWidth = 0;
    _innerLayer.transform = CATransform3DMakeScale(0, 0, 0);
    
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        
        self.alert = false;
        
        CAKeyframeAnimation * ovalTransformAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        ovalTransformAnim.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)],
                                     [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1)],
                                     [NSValue valueWithCATransform3D:CATransform3DIdentity]];
        ovalTransformAnim.keyTimes = @[@0, @0.6, @1];
        ovalTransformAnim.duration = 0.5;
        ovalTransformAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        ovalTransformAnim.removedOnCompletion = NO;
        ovalTransformAnim.fillMode = kCAFillModeForwards;
        
        [self.innerLayer addAnimation:ovalTransformAnim forKey:@"selectedAnimation"];
        
        if (self.checkedCompletion) {
            self.checkedCompletion();
        }
    } else {
        CAKeyframeAnimation * ovalTransformAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        ovalTransformAnim.values = @[[NSValue valueWithCATransform3D:CATransform3DIdentity],
                                     [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1)],
                                     [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)]];
        ovalTransformAnim.keyTimes = @[@0, @0.24, @1];
        ovalTransformAnim.duration = 0.5;
        ovalTransformAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        ovalTransformAnim.removedOnCompletion = NO;
        ovalTransformAnim.fillMode = kCAFillModeForwards;
        [self.innerLayer addAnimation:ovalTransformAnim forKey:@"unSelectedAnimation"];
        
        if (self.uncheckedCompletion) {
            self.uncheckedCompletion();
        }
    }
}

- (void)showAlert {
    self.alert = self.selected ? false : true;
}

- (BOOL)isChecked {
    return self.selected;
}

- (void)setAlert:(BOOL)alert {
    if (_alert != alert) {
        _alert = alert;
        if (alert) {
            self.outerLayer.strokeColor = self.alartColor.CGColor;
        } else {
            self.outerLayer.strokeColor = self.outerColor.CGColor;
        }
    }
}

- (void)setInnerColor:(UIColor *)innerColor {
    if (_innerColor != innerColor) {
        _innerColor = innerColor;
        self.innerLayer.fillColor = innerColor.CGColor;
        self.innerLayer.strokeColor = innerColor.CGColor;
    }
}

- (void)setOuterColor:(UIColor *)outerColor {
    if (_outerColor != outerColor) {
        _outerColor = outerColor;
        self.outerLayer.strokeColor = outerColor.CGColor;
    }
}

- (void)setAlartColor:(UIColor *)alartColor {
    if (_alartColor != alartColor) {
        _alartColor = alartColor;
        if (self.alert) {
            self.outerLayer.strokeColor = alartColor.CGColor;
        }
    }
}

- (void)setCheckBoxStyle:(JCCheckBoxStyle)checkBoxStyle {
    if (_checkBoxStyle != checkBoxStyle) {
        _checkBoxStyle = checkBoxStyle;
        [self setUpLayers];
    }
}

- (UIBezierPath *)getPath:(CGRect)bounds {
    switch (self.checkBoxStyle) {
        case JCCheckBoxStyleSquare:
            return [self rectanglePathWithBounds:bounds];
            break;
        case JCCheckBoxStyleOval:
            return [self ovalPathWithBounds:bounds];
            break;
        default:
            break;
    }
}

#pragma mark - Bezier Path

- (UIBezierPath *)ovalPathWithBounds:(CGRect)bounds{
    UIBezierPath * ovalPath = [UIBezierPath bezierPathWithOvalInRect:bounds];
    return ovalPath;
}

- (UIBezierPath *)rectanglePathWithBounds:(CGRect)bounds{
    UIBezierPath * rectanglePath = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:3.0f];
    return rectanglePath;
}

#pragma mark - Touch event handle

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    [super touchesEnded:touches withEvent:event];
    if (self.allTargets.count == 0) {
        self.selected = !self.selected;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer *)gestureRecognizer;
        if (tapGesture.numberOfTapsRequired == 1 && tapGesture.numberOfTouchesRequired == 1) {
            return false;
        }
    }
    return true;
}


@end
