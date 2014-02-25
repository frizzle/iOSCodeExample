
#import "ViewController.h"
#import "SliderContentViewControllerDelegate.h"

#define kNotificationSliderDidOpened @"keyNotificationSliderDidOpened"
#define kNotificationSliderDidClosed @"keyNotificationSliderDidClosed"

@class DirectionPanGestureRecognizer;

@interface SliderMenuViewController : ViewController <UIGestureRecognizerDelegate, SliderContentViewControllerDelegate>
{
    DirectionPanGestureRecognizer   *_sliderGestureRecognizer;
    CGFloat                         _offset;
    BOOL                            _isSliderOpened;
    
    //MenuItemType _currentMenuView;
}

@property (weak, nonatomic) IBOutlet    UIView                  *sliderView;
@property (weak, nonatomic) IBOutlet    UIView                  *sliderContentView;

@property (nonatomic, strong)           SliderContentViewController *sliderContentController;
@property (nonatomic, strong)           NavigationController    *navigationController;


- (void)addViewToSlider:(UIView *)view;
- (void)openSliderWithView:(UIView *)view animated:(BOOL)animated;
- (void)hideSliderAnimated:(BOOL)animated;

@end
