//
//  TJButton.h
//  Opener
//
//  Created by Tim Johnsen on 3/17/21.
//  Copyright © 2021 tijo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TJButton : UIButton

- (void)setBackgroundColor:(nullable UIColor *)backgroundColor forState:(UIControlState)state;
- (void)setTintColor:(nullable UIColor *)backgroundColor forState:(UIControlState)state;

@property (nonatomic) UIEdgeInsets hitOutsets;

// Marked as deprecated by UIKit in iOS 15, this un-marks it as deprecated.
@property (nonatomic) UIEdgeInsets titleEdgeInsets;

@end

@interface UIView (TJButtonAdditions)

- (void)tj_applyCornerRadius:(const CGFloat)cornerRadius
                 borderWidth:(const CGFloat)borderWidth
                 borderColor:(const CGColorRef)borderColor;

@end

NS_ASSUME_NONNULL_END
