//
//  UIView+TouchShrinkable.m
//  KYFoundationKit
//
//  Created by Qitao Yang on 2018/5/2.
//  Copyright © 2018年 Qitao Yang. All rights reserved.
//

#import "UIView+TouchShrinkable.h"
#import "KYUtilityHelper.h"

@implementation UIView (TouchShrinkable)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ImplementTouchMethodsIfNeeded(self.class, @selector(touchesBegan:withEvent:));
        ImplementTouchMethodsIfNeeded(self.class, @selector(touchesCancelled:withEvent:));
        ImplementTouchMethodsIfNeeded(self.class, @selector(touchesEnded:withEvent:));
        KY_Swizzle(self, @selector(touchesBegan:withEvent:), @selector(kyTouchesBegan:withEvent:));
        KY_Swizzle(self, @selector(touchesEnded:withEvent:), @selector(kyTouchesEnded:withEvent:));
        KY_Swizzle(self, @selector(touchesCancelled:withEvent:), @selector(kyTouchesCancelled:withEvent:));
    });
}

- (void)setTouchShrinkable:(BOOL)touchShrinkable {
    objc_setAssociatedObject(self, @selector(touchShrinkable), @(touchShrinkable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)touchShrinkable {
    return [objc_getAssociatedObject(self, @selector(touchShrinkable)) boolValue];
}

- (void)kyTouchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self respondsToSelector:@selector(touchesBegan:withEvent:)]) {
        [self kyTouchesBegan:touches withEvent:event];
    }
    if (self.touchShrinkable) {
        [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
            self.transform = CGAffineTransformScale(self.transform, 0.9, 0.9);
        } completion:nil];
    }
}

- (void)kyTouchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self respondsToSelector:@selector(touchesEnded:withEvent:)]) {
        [self kyTouchesEnded:touches withEvent:event];
    }
    if (self.touchShrinkable) {
        [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
            self.transform = CGAffineTransformScale(self.transform, 1.0/0.9, 1.0/0.9);
        } completion:nil];
    }
}

- (void)kyTouchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self respondsToSelector:@selector(touchesCancelled:withEvent:)]) {
        [self kyTouchesCancelled:touches withEvent:event];
    }
    if (self.touchShrinkable) {
        [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
            self.transform = CGAffineTransformScale(self.transform, 1.0/0.9, 1.0/0.9);
        } completion:nil];
    }
}

@end


@implementation UIView (ExtendTouchRect)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        KY_Swizzle(self, @selector(pointInside:withEvent:), @selector(myPointInside:withEvent:));
    });
}

- (BOOL)myPointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.touchExtendInset, UIEdgeInsetsZero) || self.hidden ||
        ([self isKindOfClass:UIControl.class] && !((UIControl *)self).enabled)) {
        return [self myPointInside:point withEvent:event]; // original implementation
    }
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.touchExtendInset);
    hitFrame.size.width = MAX(hitFrame.size.width, 0); // don't allow negative sizes
    hitFrame.size.height = MAX(hitFrame.size.height, 0);
    return CGRectContainsPoint(hitFrame, point);
}

- (void)setTouchExtendInset:(UIEdgeInsets)touchExtendInset {
    objc_setAssociatedObject(self, @selector(touchExtendInset), [NSValue valueWithUIEdgeInsets:touchExtendInset],
                             OBJC_ASSOCIATION_RETAIN);
}

- (UIEdgeInsets)touchExtendInset {
    return [objc_getAssociatedObject(self, @selector(touchExtendInset)) UIEdgeInsetsValue];
}

@end

