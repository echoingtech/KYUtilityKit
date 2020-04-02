//
//  KYControl.h
//  KYUtilityKit
//
//  Created by Qitao Yang on 2020/4/2.
//

#import <UIKit/UIKit.h>
#import "KYGestureRecognizer.h"

NS_ASSUME_NONNULL_BEGIN

@class KYControl;
typedef void(^KYControlBlock)(KYControl *view, KYGestureRecognizerState state, NSSet *touches, UIEvent *event);
typedef void(^KYControlLongPressBlock)(KYControl *view, CGPoint point);

@interface KYControl : UIView
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) KYControlBlock touchBlock;
@property (nonatomic, copy) KYControlLongPressBlock longPressBlock;
@end

NS_ASSUME_NONNULL_END


