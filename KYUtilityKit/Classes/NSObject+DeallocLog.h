//
//  NSObject+DeallocLog.h
//  KYFoundationKit
//
//  Created by Qitao Yang on 2018/5/2.
//  Copyright © 2018年 Qitao Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DeallocLog)

@property (nonatomic, readonly) NSString * _Nonnull nameOfClass;
@property (nonatomic, assign)  BOOL ky_shouldLogWhenDealloc;

- (NSString *_Nonnull)ky_memoryAddress;
+ (NSString *_Nonnull)NameOfClass;

@end
