//
//  UIGestureRecognizer+Opertation.m
//  BAQMUIDemo
//
//  Created by 博爱 on 15/10/16.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "UIGestureRecognizer+Opertation.h"
#import <objc/runtime.h>

static char opertationKey;
static char beganOpertationKey;
static char changedOpertationKey;
static char cancelledOpertationKey;
static char endOpertationKey;
static char failedOpertationKey;

static char swipeRightOpertationKey;
static char swipeLeftOpertationKey;
static char swipeUpOpertationKey;
static char swipeDownOpertationKey;

@implementation UIGestureRecognizer (Opertation)

- (void)setOpertation:(GestureOpertation)opertation {
    
    objc_setAssociatedObject(self, &opertationKey, opertation, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (GestureOpertation)opertation {
    
    return objc_getAssociatedObject(self, &opertationKey);
}

- (void)setBeganOpertation:(GestureOpertation)beganOpertation {
    
    objc_setAssociatedObject(self, &beganOpertationKey, beganOpertation, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (GestureOpertation)beganOpertation {
    
    return objc_getAssociatedObject(self, &beganOpertationKey);
}

- (void)setChangedOpertation:(GestureOpertation)changedOpertation {
    
    objc_setAssociatedObject(self, &changedOpertationKey, changedOpertation, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (GestureOpertation)changedOpertation {
    
    return objc_getAssociatedObject(self, &changedOpertationKey);
}

- (void)setCancelledOpertation:(GestureOpertation)cancelledOpertation {
    
    objc_setAssociatedObject(self, &cancelledOpertationKey, cancelledOpertation, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (GestureOpertation)cancelledOpertation {
    
    return objc_getAssociatedObject(self, &cancelledOpertationKey);
}
- (void)setEndOpertation:(GestureOpertation)endOpertation {
    
    objc_setAssociatedObject(self, &endOpertationKey, endOpertation, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (GestureOpertation)endOpertation {
    
    return objc_getAssociatedObject(self, &endOpertationKey);
}
- (void)setFailedOpertation:(GestureOpertation)failedOpertation {
    
    objc_setAssociatedObject(self, &failedOpertationKey, failedOpertation, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (GestureOpertation)failedOpertation {
    
    return objc_getAssociatedObject(self, &failedOpertationKey);
}

- (void)setSwipeRightOpertation:(GestureOpertation)swipeRightOpertation {
    
    objc_setAssociatedObject(self, &swipeRightOpertationKey, swipeRightOpertation, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (GestureOpertation)swipeRightOpertation {
    
    return objc_getAssociatedObject(self, &swipeRightOpertationKey);
}
- (void)setSwipeLeftOpertation:(GestureOpertation)swipeLeftOpertation {
    
    objc_setAssociatedObject(self, &swipeLeftOpertationKey, swipeLeftOpertation, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (GestureOpertation)swipeLeftOpertation {
    
    return objc_getAssociatedObject(self, &swipeLeftOpertationKey);
}
- (void)setSwipeUpOpertation:(GestureOpertation)swipeUpOpertation {
    
    objc_setAssociatedObject(self, &swipeUpOpertationKey, swipeUpOpertation, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (GestureOpertation)swipeUpOpertation {
    
    return objc_getAssociatedObject(self, &swipeUpOpertationKey);
}
- (void)setSwipeDownOpertation:(GestureOpertation)swipeDownOpertation {
    
    objc_setAssociatedObject(self, &swipeDownOpertationKey, swipeDownOpertation, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (GestureOpertation)swipeDownOpertation {
    
    return objc_getAssociatedObject(self, &swipeDownOpertationKey);
}

- (instancetype)addOpertation:(GestureOpertation)opertation {
    self.opertation = opertation;
    return self;
}
- (instancetype)addBeganOpertation:(GestureOpertation)beganOpertation {
    self.beganOpertation = beganOpertation;
    return self;
}
- (instancetype)addChangedOpertation:(GestureOpertation)changedOpertation {
    self.changedOpertation = changedOpertation;
    return self;
}
- (instancetype)addCancelledOpertation:(GestureOpertation)cancelledOpertation {
    self.cancelledOpertation = cancelledOpertation;
    return self;
}
- (instancetype)addEndOpertation:(GestureOpertation)endOpertation {
    self.endOpertation = endOpertation;
    return self;
}
- (instancetype)addFailedOpertation:(GestureOpertation)failedOpertation {
    self.failedOpertation = failedOpertation;
    return self;
}

- (instancetype)addSwipeRightOpertation:(GestureOpertation)swipeRightOpertation {
    self.swipeRightOpertation = swipeRightOpertation;
    return self;
}
- (instancetype)addSwipeLeftOpertation:(GestureOpertation)swipeLeftOpertation {
    self.swipeLeftOpertation = swipeLeftOpertation;
    return self;
}
- (instancetype)addSwipeUpOpertation:(GestureOpertation)swipeUpOpertation {
    self.swipeUpOpertation = swipeUpOpertation;
    return self;
}
- (instancetype)addSwipeDownOpertation:(GestureOpertation)swipeDownOpertation {
    self.swipeDownOpertation = swipeDownOpertation;
    return self;
}
@end
