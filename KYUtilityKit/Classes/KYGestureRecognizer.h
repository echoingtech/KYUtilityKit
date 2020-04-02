//
//  KYGestureRecognizer.h
//  KYUtilityKit
//
//  Created by Qitao Yang on 2020/4/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// State of the gesture
typedef NS_ENUM(NSUInteger, KYGestureRecognizerState) {
  KYGestureRecognizerStateBegan, ///< gesture start
  KYGestureRecognizerStateMoved, ///< gesture moved
  KYGestureRecognizerStateEnded, ///< gesture end
  KYGestureRecognizerStateCancelled, ///< gesture cancel
};

/**
 A simple UIGestureRecognizer subclass for receive touch events.
 */
@interface KYGestureRecognizer : UIGestureRecognizer

@property (nonatomic, readonly) CGPoint startPoint; ///< start point
@property (nonatomic, readonly) CGPoint lastPoint; ///< last move point.
@property (nonatomic, readonly) CGPoint currentPoint; ///< current move point.

/// The action block invoked by every gesture event.
@property (nonatomic, copy) void (^action)(KYGestureRecognizer *gesture, KYGestureRecognizerState state);

/// Cancel the gesture for current touch.
- (void)cancel;

@end


NS_ASSUME_NONNULL_END
