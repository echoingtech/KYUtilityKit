//
//  KYControl.m
//  KYUtilityKit
//
//  Created by Qitao Yang on 2020/4/2.
//

#import "KYControl.h"

@implementation KYControl {
    UIImage *_image;
    CGPoint _point;
    NSTimer *_timer;
    BOOL _longPressDetected;
    CGPoint _beginPoint;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.touchScaleEnable = YES;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.touchScaleEnable = YES;
    }
    
    return self;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.layer.contents = (id)image.CGImage;
}

- (void)dealloc {
    [self endTimer];
}

- (UIImage *)image {
    id content = self.layer.contents;
    if (content != (id)_image.CGImage) {
        CGImageRef ref = (__bridge CGImageRef)(content);
        if (ref && CFGetTypeID(ref) == CGImageGetTypeID()) {
            _image = [UIImage imageWithCGImage:ref scale:self.layer.contentsScale orientation:UIImageOrientationUp];
        } else {
            _image = nil;
        }
    }
    return _image;
}

- (void)startTimer {
    [_timer invalidate];
    _timer = [NSTimer timerWithTimeInterval:0.4 target:self selector:@selector(timerFire) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)endTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)timerFire {
    [self touchesCancelled:[NSSet set] withEvent:nil];
    _longPressDetected = YES;
    if (_longPressBlock) _longPressBlock(self, _point);
    [self endTimer];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.touchScaleEnable) {
        [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
            self.transform = CGAffineTransformScale(self.transform, 0.95, 0.95);
        } completion:nil];
    }
    _longPressDetected = NO;
    if (_touchBlock) {
        _touchBlock(self, KYGestureRecognizerStateBegan, touches, event);
    }
    if (_longPressBlock) {
        UITouch *touch = touches.anyObject;
        _point = [touch locationInView:self];
        [self startTimer];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (_longPressDetected) return;
    if (_touchBlock) {
        _touchBlock(self, KYGestureRecognizerStateMoved, touches, event);
    }
    UITouch *touch=[touches anyObject];
    CGFloat distance = [self CGPointDistance:[touch locationInView:self] point2:_point];
    if (distance > 10.0) {
        [self endTimer];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.touchScaleEnable) {
        [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
    if (_longPressDetected) return;
    if (_touchBlock) {
        _touchBlock(self, KYGestureRecognizerStateEnded, touches, event);
    }
    [self endTimer];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.touchScaleEnable) {
        [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
    if (_longPressDetected) return;
    if (_touchBlock) {
        _touchBlock(self, KYGestureRecognizerStateCancelled, touches, event);
    }
    [self endTimer];
}

- (CGFloat)CGPointDistance:(CGPoint)p1 point2:(CGPoint)p2 {
    return sqrt((p1.x-p2.x)*(p1.x-p2.x) + (p1.y-p2.y)*(p1.y-p2.y));
}

@end
