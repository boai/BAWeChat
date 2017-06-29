//
//  UIView+Gesture.m
//  BAQMUIDemo
//
//  Created by 博爱 on 15/10/16.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "UIView+Gesture.h"

@implementation UIView (Gesture)

- (UITapGestureRecognizer *)addTapGestureRecognizer {
    
    return [self addTapGestureRecognizer:nil];
}
- (UITapGestureRecognizer *)addTapGestureRecognizer:(void(^)(UITapGestureRecognizer *tapGesture))tapGesture {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureClick:)];
    if (tapGesture) {
        tapGesture(tap);
    }
    [self addGestureRecognizer:tap];
    return tap;
}
- (UIPanGestureRecognizer *)addPanGestureRecognizer {
    
    return [self addPanGestureRecognizer:nil];
}
- (UIPanGestureRecognizer *)addPanGestureRecognizer:(void(^)(UIPanGestureRecognizer *panGesture))panGesture {
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureClick:)];
    if (panGesture) {
        panGesture(pan);
    }
    [self addGestureRecognizer:pan];
    return pan;
}
- (UIPinchGestureRecognizer *)addPinchGestureRecognizer {
    
    return [self addPinchGestureRecognizer:nil];
}
- (UIPinchGestureRecognizer *)addPinchGestureRecognizer:(void(^)(UIPinchGestureRecognizer *pinGesture))pinGesture {
    
    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(gestureClick:)];
    if (pinGesture) {
        pinGesture(pin);
    }
    [self addGestureRecognizer:pin];
    return pin;
    
}
- (UIRotationGestureRecognizer *)addRotationGestureRecognizer {
    
    return [self addRotationGestureRecognizer:nil];
}
- (UIRotationGestureRecognizer *)addRotationGestureRecognizer:(void(^)(UIRotationGestureRecognizer *rotationGesture))rotationGesture {
    
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(gestureClick:)];
    if (rotationGesture) {
        rotationGesture(rotation);
    }
    [self addGestureRecognizer:rotation];
    return rotation;
}
- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer {
    
    return [self addLongPressGestureRecognizer:nil];
}
- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(void(^)(UILongPressGestureRecognizer *longGesture))longGesture {
    
    UILongPressGestureRecognizer *longG = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(gestureClick:)];
    if (longGesture) {
        longGesture(longG);
    }
    [self addGestureRecognizer:longG];
    return longG;
}
- (UISwipeGestureRecognizer *)addSwipeGestureRecognizer:(SwipeDirection)type {
    return [self addSwipeGestureRecognizer:type gestureRecognizer:nil];
}
- (UISwipeGestureRecognizer *)addSwipeGestureRecognizer:(SwipeDirection)type gestureRecognizer:(void(^)(UISwipeGestureRecognizer *swipeGesture))swipeGesture {
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeClick:)];
    switch (type) {
        case 1:
            swipe.direction = UISwipeGestureRecognizerDirectionRight;
            break;
        case 2:
            swipe.direction = UISwipeGestureRecognizerDirectionLeft;
            break;
        case 3:
            swipe.direction = UISwipeGestureRecognizerDirectionUp;
            break;
        case 4:
            swipe.direction = UISwipeGestureRecognizerDirectionDown;
            break;
        default:
            break;
    }
    
    if (swipeGesture) {
        swipeGesture(swipe);
    }
    [self addGestureRecognizer:swipe];
    return swipe;
}
- (void)swipeClick:(UISwipeGestureRecognizer *)gesture {
    
    switch (gesture.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            if (gesture.swipeRightOpertation) {
                gesture.swipeRightOpertation(gesture);
            }
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            if (gesture.swipeLeftOpertation) {
                gesture.swipeLeftOpertation(gesture);
            }
            break;
        case UISwipeGestureRecognizerDirectionUp:
            if (gesture.swipeUpOpertation) {
                gesture.swipeUpOpertation(gesture);
            }
            break;
        case UISwipeGestureRecognizerDirectionDown:
            if (gesture.swipeDownOpertation) {
                gesture.swipeDownOpertation(gesture);
            }
            break;
        default:
            break;
    }
}
- (void)gestureClick:(UIGestureRecognizer *)gesture {
    
    if (gesture.opertation) {
        gesture.opertation(gesture);
        return;
    }
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            if (gesture.beganOpertation) {
                gesture.beganOpertation(gesture);
            }
            break;
        case UIGestureRecognizerStateChanged:
            if (gesture.changedOpertation) {
                gesture.changedOpertation(gesture);
            }
            break;
        case UIGestureRecognizerStateCancelled:
            if (gesture.cancelledOpertation) {
                gesture.cancelledOpertation(gesture);
            }
            break;
        case UIGestureRecognizerStateFailed:
            if (gesture.failedOpertation) {
                gesture.failedOpertation(gesture);
            }
            break;
        case UIGestureRecognizerStateEnded:
            if (gesture.endOpertation) {
                gesture.endOpertation(gesture);
            }
        default:
            break;
    }
}
@end
