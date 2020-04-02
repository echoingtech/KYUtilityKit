//
//  KYGestureRecognizer.m
//  KYUtilityKit
//
//  Created by Qitao Yang on 2020/4/2.
//

#import "KYGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation KYGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  self.state = UIGestureRecognizerStateBegan;
  _startPoint = [(UITouch *)[touches anyObject] locationInView:self.view];
  _lastPoint = _currentPoint;
  _currentPoint = _startPoint;
  if (_action) _action(self, KYGestureRecognizerStateBegan);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = (UITouch *)[touches anyObject];
  CGPoint currentPoint = [touch locationInView:self.view];
  self.state = UIGestureRecognizerStateChanged;
  _currentPoint = currentPoint;
  if (_action) _action(self, KYGestureRecognizerStateMoved);
  _lastPoint = _currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  self.state = UIGestureRecognizerStateEnded;
  if (_action) _action(self, KYGestureRecognizerStateEnded);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  self.state = UIGestureRecognizerStateCancelled;
  if (_action) _action(self, KYGestureRecognizerStateCancelled);
}

- (void)reset {
  self.state = UIGestureRecognizerStatePossible;
}

- (void)cancel {
  if (self.state == UIGestureRecognizerStateBegan || self.state == UIGestureRecognizerStateChanged) {
    self.state = UIGestureRecognizerStateCancelled;
    if (_action) _action(self, KYGestureRecognizerStateCancelled);
  }
}

@end
