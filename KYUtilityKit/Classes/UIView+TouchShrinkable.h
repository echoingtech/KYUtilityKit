//
//  UIView+TouchShrinkable.h
//  KYFoundationKit
//
//  Created by Qitao Yang on 2018/5/2.
//  Copyright © 2018年 Qitao Yang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (TouchShrinkable)

@property (nonatomic, assign)BOOL touchShrinkable;

@end


@interface UIView (ExtendTouchRect)

@property (nonatomic, assign)UIEdgeInsets touchExtendInset;

@end
