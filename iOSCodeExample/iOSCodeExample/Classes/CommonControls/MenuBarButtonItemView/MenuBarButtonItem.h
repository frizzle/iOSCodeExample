
#import "BarButtonItem.h"
#import "MenuBarButtonItemDelegate.h"

typedef NS_ENUM(NSInteger, MenuBarButtonStyle) {
    MenuBarButtonStyleMenu,
    MenuBarButtonStyleBack
};

@interface MenuBarButtonItem : BarButtonItem

@property (nonatomic, weak) id<MenuBarButtonItemDelegate>       delegate;
@property (nonatomic)       MenuBarButtonStyle                  itemStyle;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView    *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton                   *barButton;

- (IBAction)menuButtonClick:(id)sender;

@end
