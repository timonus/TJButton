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
    [self _updateBackgroundColor];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self _updateBackgroundColor];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self _updateBackgroundColor];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self _updateBackgroundColor];
}

- (void)_updateBackgroundColor {
    const UIControlState state = self.state;
    UIColor *color = _backgroundColorsForStates[@(state)];
    if (!color && state != UIControlStateNormal) {
        color = _backgroundColorsForStates[@(UIControlStateNormal)];
    }
    [super setBackgroundColor:color];
}

@end

@implementation UIView (TJButtonAdditions)

- (void)tj_applyCornerRadius:(const CGFloat)cornerRadius
                 borderWidth:(const CGFloat)borderWidth
                 borderColor:(const CGColorRef)borderColor
{
    self.layer.cornerRadius = cornerRadius;
    if (@available(iOS 13.0, *)) {
        self.layer.cornerCurve = kCACornerCurveContinuous;
    }
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor;
}

@end
