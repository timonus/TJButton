//
//  TJButton.m
//  Opener
//
//  Created by Tim Johnsen on 3/17/21.
//  Copyright © 2021 tijo. All rights reserved.
//

#import "TJButton.h"

@implementation TJButton {
    NSMutableDictionary<NSNumber *, UIColor *> *_backgroundColorsForStates;
    NSMutableDictionary<NSNumber *, UIColor *> *_tintColorsForStates;
}

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
                 borderColor:(const CGColorRef)borderColor
{
    self.layer.cornerRadius = cornerRadius;
#if !defined(__IPHONE_13_0) || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_13_0
    if (@available(iOS 13.0, *))
#endif
    {
        self.layer.cornerCurve = kCACornerCurveContinuous;
    }
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor;
}

@end
