//
//  TJButton.m
//  Opener
//
//  Created by Tim Johnsen on 3/17/21.
//  Copyright © 2021 tijo. All rights reserved.
//

#import "TJButton.h"
#import <objc/runtime.h>

@implementation TJButton {
    NSMutableDictionary<NSNumber *, UIColor *> *_backgroundColorsForStates;
    NSMutableDictionary<NSNumber *, UIColor *> *_tintColorsForStates;
}

@dynamic titleEdgeInsets;

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [self setBackgroundColor:backgroundColor forState:UIControlStateNormal];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    if (!_backgroundColorsForStates) {
        _backgroundColorsForStates = [NSMutableDictionary new];
    }
    _backgroundColorsForStates[@(state)] = backgroundColor;
    [self _updateForState];
}

- (void)setTintColor:(UIColor *)tintColor
{
    [self setTintColor:tintColor forState:UIControlStateNormal];
}

- (void)setTintColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    if (!_tintColorsForStates) {
        _tintColorsForStates = [NSMutableDictionary new];
    }
    _tintColorsForStates[@(state)] = backgroundColor;
    [self _updateForState];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self _updateForState];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self _updateForState];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self _updateForState];
}

- (void)_updateForState __attribute__((objc_direct))
{
    const UIControlState state = self.state;
    NSNumber *const stateKey = @(self.state);
    
    // Background color
    UIColor *backgroundColor = _backgroundColorsForStates[stateKey];
    if (!backgroundColor && state != UIControlStateNormal) {
        backgroundColor = _backgroundColorsForStates[@(UIControlStateNormal)];
    }
    [super setBackgroundColor:backgroundColor];
    
    // Tint color
    UIColor *tintColor = _tintColorsForStates[stateKey];
    if (!tintColor && state != UIControlStateNormal) {
        tintColor = _tintColorsForStates[@(UIControlStateNormal)];
    }
    [super setTintColor:tintColor];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return [super pointInside:point withEvent:event] ||
    CGRectContainsPoint(UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(-_hitOutsets.top, -_hitOutsets.left, -_hitOutsets.bottom, -_hitOutsets.right)), point);
}

@end

__attribute__((objc_direct_members))
@implementation UIView (TJButtonAdditions)

- (void)tj_applyCornerRadius:(const CGFloat)cornerRadius
                 borderWidth:(const CGFloat)borderWidth
                 borderColor:(UIColor *const)borderColor
{
    self.layer.cornerRadius = cornerRadius;
#if !defined(__IPHONE_13_0) || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_13_0
    if (@available(iOS 13.0, *))
#endif
    {
        self.layer.cornerCurve = kCACornerCurveContinuous;
    }
    self.layer.borderWidth = borderWidth;
    self.borderColor = borderColor;
}

- (void)setBorderColor:(UIColor *)color
{
    if (@available(iOS 17.0, *)) {
        id<UITraitChangeRegistration> formerRegistration = objc_getAssociatedObject(self, @selector(borderColor));
        if (formerRegistration) {
            [self unregisterForTraitChanges:formerRegistration];
        }
        if (color) {
            id registration = [self registerForTraitChanges:@[[UITraitUserInterfaceStyle class]] withHandler:^(__kindof id<UITraitEnvironment>  _Nonnull traitEnvironment, UITraitCollection * _Nonnull previousCollection) {
                [[(UIView *)traitEnvironment layer] setBorderColor:color.CGColor];
            }];
            objc_setAssociatedObject(self, @selector(borderColor), registration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    self.layer.borderColor = color.CGColor;
}

- (UIColor *)borderColor
{
    CGColorRef borderColor = self.layer.borderColor;
    if (borderColor) {
        return [UIColor colorWithCGColor:borderColor];
    }
    return nil;
}

@end
