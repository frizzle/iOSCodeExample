
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BarButtonItemState) {
    BarButtonItemStateDefault    = 0, 
    BarButtonItemStateHidden     = 1,
    BarButtonItemStateFulscreen  = 2,
};

@interface BarButtonItem : UIView

@property (nonatomic) BarButtonItemState itemState;
@property (nonatomic, weak) IBOutlet UIView *defultStateView;
@property (nonatomic, weak) IBOutlet UIView *fullscreenStateView;

- (void)setItemState:(BarButtonItemState)itemState animated:(BOOL)animated;

@end
