/*
 Recognizer with parameters which direction should be recognized horizontal or vertical
 */

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

typedef enum {
    DirectionPangestureRecognizerVertical,
    DirectionPanGestureRecognizerHorizontal
} DirectionPangestureRecognizerDirection;

@interface DirectionPanGestureRecognizer : UIPanGestureRecognizer {
    BOOL _drag;
    int _moveX;
    int _moveY;
}

@property (nonatomic, assign) DirectionPangestureRecognizerDirection direction;

@end