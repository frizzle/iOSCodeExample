

#import "BarButtonItem.h"

@implementation BarButtonItem

@synthesize itemState           = _itemState;

@synthesize defultStateView     = _defultStateView;
@synthesize fullscreenStateView = _fullscreenStateView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _itemState = BarButtonItemStateDefault;
    }
    return self;
}

- (void)setItemState:(BarButtonItemState)itemState
{
    _itemState = itemState;

    [self reloadItemState];
}

- (void)setItemState:(BarButtonItemState)itemState animated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.3f animations:^(void){
            [self setItemState:itemState];
        }];
    } else {
        [self setItemState:itemState];
    }
}

- (void)setDefultStateView:(UIView *)defultStateView {
    if (_defultStateView != nil) {
        [_defultStateView removeFromSuperview];
    }
    _defultStateView = defultStateView;
    [self addSubview:_defultStateView];
}

- (void)setFullscreenStateView:(UIView *)fullscreenStateView
{
    if (_fullscreenStateView != nil) {
        [_fullscreenStateView removeFromSuperview];
    }
    _fullscreenStateView = fullscreenStateView;
    [self addSubview:_fullscreenStateView];
}

- (void)reloadItemState
{
    switch (_itemState) {
        case BarButtonItemStateHidden:
            _defultStateView.alpha      = 0.0f;
            _fullscreenStateView.alpha  = 0.0f;
            break;
        case BarButtonItemStateDefault:
            _defultStateView.alpha      = 1.0f;
            _fullscreenStateView.alpha  = 0.0f;
            break;
        case BarButtonItemStateFulscreen:
            _defultStateView.alpha      = 0.0f;
            _fullscreenStateView.alpha  = 1.0f;
            break;
    }
}

@end
