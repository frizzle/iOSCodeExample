
#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize navigationBarTitle      = _navigationBarTitle;

@synthesize backgroundImageView     = _backgroundImageView;
@synthesize activityIndicator       = _activityIndicator;

@synthesize rightBarButtonItem      = _rightBarButtonItem;
@synthesize leftBarButtonItem       = _leftBarButtonItem;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidUnload {
    self.backgroundImageView = nil;
    self.activityIndicator = nil;
    self.rightBarButtonItem = nil;
    self.leftBarButtonItem = nil;
    
    [super viewDidUnload];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }

}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Actions
- (IBAction)buttonCloseClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)buttonBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)menuButtonClick:(id)sender {

}

#pragma mark Autorotation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{

    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// iOS 6 rotation features
- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientation
{
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark Properties
- (void)setNavigationBarTitle:(NSString *)navigationBarTitle
{
    _navigationBarTitle = navigationBarTitle;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];

    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setAdjustsFontSizeToFitWidth:YES];
    if ([titleLabel respondsToSelector:@selector(setMinimumScaleFactor:)]) {
        [titleLabel setMinimumScaleFactor:0.5f];
    }

    titleLabel.backgroundColor = [UIColor clearColor];
    
    UIColor *titleColor = nil;
    UIColor *shadowColor = nil;
    CGSize shadowOffset = CGSizeMake(0, -1);
    
    titleColor      = [UIColor whiteColor];
    shadowColor     = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
    
    titleLabel.text = _navigationBarTitle;
    
    CGFloat titleWidth = 140.0f;
    CGFloat labelWidth = 164.0f;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0,0,titleWidth,44)];
    titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    titleView.backgroundColor = [UIColor clearColor];
    titleView.autoresizesSubviews = YES;
    [titleView addSubview:titleLabel];
    titleLabel.frame = CGRectMake((titleWidth - labelWidth)/2.0f,0,labelWidth,43);
    
    
    [self.navigationItem setTitleView:titleView];
    
    
    [titleLabel setTextColor:titleColor];
    [titleLabel setShadowColor:shadowColor];
    [titleLabel setShadowOffset:shadowOffset];
}

#pragma mark Methods

- (void)customizeNavigationBar
{
    NSString *backgroundImageName = @"navigation_bar_background.png";
    
    
    if (backgroundImageName != nil) {
        UIImage *backgroundImage = [UIImage imageNamed:backgroundImageName];
//        backgroundImage = [Utils sizableImageBothSides:backgroundImage];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage
                                                      forBarMetrics:UIBarMetricsDefault];
    }
    
    if (_leftBarButtonItem != nil && self.navigationItem.leftBarButtonItem.customView != _leftBarButtonItem) {
        UIBarButtonItem *negativeSpacer = [self createNegativeSpacer];
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBarButtonItem];
        barButtonItem.style = UIBarButtonItemStylePlain;
        [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, barButtonItem, nil]];
    }
    
    if (_rightBarButtonItem != nil && self.navigationItem.rightBarButtonItem.customView != _rightBarButtonItem) {
        UIBarButtonItem *negativeSpacer = [self createNegativeSpacer];
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBarButtonItem];
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, barButtonItem, nil]];
    }
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}


//Need it for make distances from screens edge equal on ios 6 and ios 7
- (UIBarButtonItem *)createNegativeSpacer {
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        negativeSpacer.width = -10;
    }
    
    return negativeSpacer;
}

- (void)loadBackgroundImage
{
    self.backgroundImageView.image = [UIImage imageNamed:@"background_image.png"];
}

- (void)openBrowserWithURLString:(NSString *)URLString
{
/*
 Open browser controller
 */
}



@end
