
#import <Foundation/Foundation.h>

@class SliderContentViewController;

@protocol SliderContentViewControllerDelegate <NSObject>

- (void)sliderContentDidClickMenuButton:(SliderContentViewController *)contentController;
- (void)sliderContentTryToPresentViewController:(UIViewController *)viewController;
- (void)sliderContentTurnOffGestureRecognizing;
- (void)sliderContentTurnOnGestureRecognizing;

@end
