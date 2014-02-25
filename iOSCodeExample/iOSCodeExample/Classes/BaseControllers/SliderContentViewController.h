
#import "ViewController.h"
#import "MenuBarButtonItemDelegate.h"
#import "SliderContentViewControllerDelegate.h"

@interface SliderContentViewController : ViewController <MenuBarButtonItemDelegate>

@property (nonatomic, weak) id<SliderContentViewControllerDelegate> delegate;
@property (nonatomic) BOOL isFirstInNavigationStack;

- (void)sliderDidCloseHandler:(NSNotification *)notification;
- (void)sliderDidOpenHandler:(NSNotification *)notification;

@end
