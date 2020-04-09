//
//  KYUtilityHelper.h
//  KYUtilityKit
//
//  Created by Qitao Yang on 2020/4/3.
//

#ifndef KYUtilityHelper_h
#define KYUtilityHelper_h

//#import <objc/runtime.h>
//#import <objc/message.h>
#import <UIKit/UIKit.h>

static inline void AsyncBackground(__nullable dispatch_block_t afterBlock) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (afterBlock) {
            afterBlock();
        }
    });
}

static inline void AsyncMain(__nullable dispatch_block_t afterBlock) {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (afterBlock) {
            afterBlock();
        }
    });
}


//static inline void KY_Swizzle(_Nonnull Class c,_Nonnull SEL origM,_Nonnull SEL newM) {
//    Method origMethod = class_getInstanceMethod(c, origM);
//    Method newMethod = class_getInstanceMethod(c, newM);
//    if (class_addMethod(c, origM, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
//        class_replaceMethod(c, newM, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
//    } else {
//        method_exchangeImplementations(origMethod, newMethod);
//    }
//}

//static NSMutableDictionary<NSString *, NSMutableSet<NSString *> *> * _Nullable SwizzledClassMethods()
//{
//    static dispatch_once_t onceToken;
//    static NSMutableDictionary *swizzledMethods = nil;
//    dispatch_once(&onceToken, ^{
//        swizzledMethods = [[NSMutableDictionary alloc] init];
//    });
//
//    return swizzledMethods;
//}


//static void ImplementTouchMethodsIfNeeded(Class _Nonnull viewClass, SEL _Nonnull aSelector)
//{
//    NSCParameterAssert(viewClass && aSelector);
//    if (!viewClass || !aSelector) {
//        return;
//    }
//    Class superclass = class_getSuperclass(viewClass);
//    NSCParameterAssert(superclass);
//    if (!superclass || !class_getInstanceMethod(superclass, aSelector)) {
//        return;
//    }
//
//    NSString *className = NSStringFromClass(viewClass);
//    NSString *methodName = NSStringFromSelector(aSelector);
//    NSMutableSet<NSString *> *swizzledMethods = [SwizzledClassMethods() objectForKey:className];
//    if ([swizzledMethods containsObject:methodName]) {
//        return;
//    }
//
//    IMP defaultIMP = imp_implementationWithBlock(^(id self, NSSet<UITouch *> *touches, UIEvent *event) {
//        struct objc_super super = {
//            .receiver = self,
//            .super_class = superclass
//        };
//        void (*touchesEventHandler)(struct objc_super *, SEL, NSSet<UITouch *> *, UIEvent *) = (__typeof__(touchesEventHandler))objc_msgSendSuper;
//        return touchesEventHandler(&super, aSelector, touches, event);
//    });
//    Method method = class_getInstanceMethod(superclass, aSelector);
//    class_addMethod(viewClass, aSelector, defaultIMP, method_getTypeEncoding(method));
//
//    if(swizzledMethods == nil) {
//        swizzledMethods = [[NSMutableSet alloc] init];
//        [SwizzledClassMethods() setObject:swizzledMethods forKey:className];
//    }
//    [swizzledMethods addObject:methodName];
//}


#endif /* KYUtilityHelper_h */

