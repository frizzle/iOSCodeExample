
#import <UIKit/UIKit.h>

#import "BarButtonItem.h"


@interface ViewController : UIViewController
{
    NSString *_viewLocalizePrefix;
}

@property (strong, nonatomic) NSString *navigationBarTitle;

@property (weak, nonatomic)     IBOutlet UIImageView                *backgroundImageView;
@property (weak, nonatomic)     IBOutlet UIActivityIndicatorView    *activityIndicator;
@property (nonatomic, strong)   IBOutlet BarButtonItem           *rightBarButtonItem;
@property (nonatomic, strong)   IBOutlet BarButtonItem           *leftBarButtonItem;



- (void)loadBackgroundImage;

- (void)customizeNavigationBar;
- (void)openBrowserWithURLString:(NSString *)URLString;

- (IBAction)buttonCloseClick:(id)sender;
- (IBAction)buttonBackClick:(id)sender;

- (IBAction)menuButtonClick:(id)sender;

@end
