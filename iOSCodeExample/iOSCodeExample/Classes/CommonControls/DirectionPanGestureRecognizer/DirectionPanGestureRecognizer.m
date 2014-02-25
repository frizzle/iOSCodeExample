//
//  DirectionPanGestureRecognizer.m
//  Community
//
//  Apphuset AS
//  Copyright Oslo Airport AS
//  All Rights Reserved.
//
//  Author: Skryabin Aleksey - Azoft
//          Roy Ivar Moe - Apphuset AS
//

#import "DirectionPanGestureRecognizer.h"

int const static kDirectionPanThreshold = 5;

@implementation DirectionPanGestureRecognizer

@synthesize direction = _direction;

- (id)initWithTarget:(id)target action:(SEL)action
{
    self = [super initWithTarget:target action:action];
    
    if (self != nil) {
        [self reset];
    }
    
    return self;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if (self.state == UIGestureRecognizerStateFailed) return;
    CGPoint nowPoint = [[touches anyObject] locationInView:self.view];
    CGPoint prevPoint = [[touches anyObject] previousLocationInView:self.view];
    _moveX += prevPoint.x - nowPoint.x;
    _moveY += prevPoint.y - nowPoint.y;
    
    if (!_drag) {
        //see if pan was horizontal or vertical
        if (abs(_moveX) >= abs(_moveY)) { //kDirectionPanThreshold) {
            if (_direction == DirectionPangestureRecognizerVertical) {
                self.state = UIGestureRecognizerStateFailed;
//                NSLog(@"1");
            } else {
                _drag = YES;
            }
        } else if (abs(_moveY) >= abs(_moveX)) { //kDirectionPanThreshold) {
            if (_direction == DirectionPanGestureRecognizerHorizontal) {
                self.state = UIGestureRecognizerStateFailed;
//                NSLog(@"2");
            } else {
                _drag = YES;
            }
        }
    }
}

- (void)reset {
    [super reset];
    _drag = NO;
    _moveX = 0;
    _moveY = 0;
}

@end