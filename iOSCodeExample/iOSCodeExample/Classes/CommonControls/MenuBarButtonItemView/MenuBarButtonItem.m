
#import "MenuBarButtonItem.h"

@implementation MenuBarButtonItem

@synthesize delegate            = _delegate;
@synthesize itemStyle           = _itemStyle;
@synthesize barButton           = _barButton;
@synthesize activityIndicator   = _activityIndicator;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    _itemStyle = MenuBarButtonStyleMenu;
}

- (void)setItemStyle:(MenuBarButtonStyle)itemStyle
{
    _itemStyle = itemStyle;
    
    switch (_itemStyle) {
        case MenuBarButtonStyleBack:
            [_barButton setImage:[UIImage imageNamed:@"navigation_bar_back_button.png"] forState:UIControlStateNormal];
            break;
        case MenuBarButtonStyleMenu:
            [_barButton setImage:[UIImage imageNamed:@"navigation_bar_menu_button.png"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (IBAction)menuButtonClick:(id)sender {
    switch (_itemStyle) {
        case MenuBarButtonStyleBack:
            [_delegate menuItemDidClickBack:self];
            break;
        case MenuBarButtonStyleMenu:
            [_delegate menuItemDidClickMenu:self];
            break;
        default:
            break;
    }
}
@end
