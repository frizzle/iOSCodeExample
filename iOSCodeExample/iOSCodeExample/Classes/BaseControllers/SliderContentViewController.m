
#import "SliderMenuViewController.h"
#import "SliderContentViewController.h"
#import "MenuBarButtonItem.h"

@interface SliderContentViewController ()

@end

@implementation SliderContentViewController

@synthesize delegate                    = _delegate;
@synthesize isFirstInNavigationStack    = _isFirstInNavigationStack;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _isFirstInNavigationStack = YES;
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationSliderDidOpened object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationSliderDidClosed object:nil];
}
- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sliderDidCloseHandler:) name:kNotificationSliderDidClosed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sliderDidOpenHandler:) name:kNotificationSliderDidOpened object:nil];
    
    if (self.leftBarButtonItem == nil) {
        MenuBarButtonItem *menuButton = [[[NSBundle mainBundle] loadNibNamed:@"MenuBarButtonItem" owner:nil options:nil] objectAtIndex:0];
        if (!_isFirstInNavigationStack) {
            menuButton.itemStyle = MenuBarButtonStyleBack;
        }
        self.leftBarButtonItem = menuButton;
        menuButton.delegate = self;
    }
    
    [super customizeNavigationBar];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationSliderDidOpened object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationSliderDidClosed object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark MenuBarButtonItemDelegate

- (void)menuItemDidClickMenu:(MenuBarButtonItem *)menuBarItem
{
    [_delegate sliderContentDidClickMenuButton:self];
}

- (void)menuItemDidClickBack:(MenuBarButtonItem *)menuBarItem
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Notification Handlers
- (void)sliderDidCloseHandler:(NSNotification *)notification
{
    //Disable interacion if slider did closed
    //And show menu button
    
    self.view.userInteractionEnabled = NO;
    if ([self.leftBarButtonItem isKindOfClass:[MenuBarButtonItem class]]) {
        MenuBarButtonItem *menuBarItem = (MenuBarButtonItem *)self.leftBarButtonItem;
        if (menuBarItem.itemStyle != MenuBarButtonStyleMenu) {
            menuBarItem.itemStyle = MenuBarButtonStyleMenu;
        }
    }
}

- (void)sliderDidOpenHandler:(NSNotification *)notification
{

    //Enable interacion if slider did closed
    //And show back button if there are more than one items in navigation stack
    self.view.userInteractionEnabled = YES;
    if ([self.leftBarButtonItem isKindOfClass:[MenuBarButtonItem class]]) {
        MenuBarButtonItem *menuBarItem = (MenuBarButtonItem *)self.leftBarButtonItem;
        if (!_isFirstInNavigationStack && menuBarItem.itemStyle == MenuBarButtonStyleMenu) {
            menuBarItem.itemStyle = MenuBarButtonStyleBack;
        }
    }
}
@end
