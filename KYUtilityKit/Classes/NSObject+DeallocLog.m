//
//  NSObject+DeallocLog.m
//  KYFoundationKit
//
//  Created by Qitao Yang on 2018/5/2.
//  Copyright © 2018年 Qitao Yang. All rights reserved.
//

#import "NSObject+DeallocLog.h"
#import "KYUtilityHelper.h"

@implementation NSObject (DeallocLog)

- (void)setKy_shouldLogWhenDealloc:(BOOL)ky_shouldLogWhenDealloc {
    objc_setAssociatedObject(self, @selector(ky_shouldLogWhenDealloc), @(ky_shouldLogWhenDealloc),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)ky_shouldLogWhenDealloc {
    return [objc_getAssociatedObject(self, @selector(ky_shouldLogWhenDealloc)) boolValue];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        KY_Swizzle(self, NSSelectorFromString(@"dealloc"), @selector(_myDealloc));
    });
}

- (NSString *_Nonnull)ky_memoryAddress; {
    return [NSString stringWithFormat:@"%p", self];
}

+ (NSString *)NameOfClass {
    return [NSStringFromClass(self) componentsSeparatedByString:@"."].lastObject;
}

- (NSString *)nameOfClass {
    return [NSStringFromClass(self.class) componentsSeparatedByString:@"."].lastObject;
}

- (void)_myDealloc {
#ifdef DEBUG
    if (self.ky_shouldLogWhenDealloc) {
        NSLog(@"----- 💀 [%@] Dealloc!",NSStringFromClass([self class]));
    }
#endif
    [self _myDealloc];
}


@end
