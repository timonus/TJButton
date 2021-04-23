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

@end

@interface UIView (TJButtonAdditions)

- (void)tj_applyCornerRadius:(const CGFloat)cornerRadius
                 borderWidth:(const CGFloat)borderWidth
                 borderColor:(const CGColorRef)borderColor;

@end

NS_ASSUME_NONNULL_END
