
#import "SliderMenuViewController.h"
#import "DirectionPanGestureRecognizer.h"

@interface SliderMenuViewController ()

@end

@implementation SliderMenuViewController

@synthesize sliderView              = _sliderView;
@synthesize sliderContentView       = _sliderContentView;
@synthesize navigationController    = _navigationController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _sliderGestureRecognizer = [[DirectionPanGestureRecognizer alloc] initWithTarget:self action:@selector(panTopbar:)];
    _sliderGestureRecognizer.direction = DirectionPanGestureRecognizerHorizontal;
    _sliderGestureRecognizer.delegate = self;
    [_sliderView addGestureRecognizer:_sliderGestureRecognizer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)panTopbar:(UIPanGestureRecognizer *)recognizer
{
    CGPoint panPoint = [recognizer translationInView:self.view];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            break;
            
        case UIGestureRecognizerStateChanged: {
            CGRect newFrame = CGRectMake(_offset + panPoint.x,
                                         _sliderView.frame.origin.y,
                                         _sliderView.frame.size.width,
                                         _sliderView.frame.size.height);
            _sliderView.frame = newFrame;

            if (self.sliderView.x < 0.0) {
                _sliderView.x = 0.0;
            }
        }
            break;
            
        case UIGestureRecognizerStateEnded:
            if (_sliderView.x < (_sliderView.width / 2)) {
                [self openSliderWithView:nil animated:YES];
                
            } else {
                [self hideSliderAnimated:YES];
            }
            break;
            
        default:
            break;
    }
}



#pragma mark Slider methods

- (void)addViewToSlider:(UIView *)view
{
    if (view != nil && ![_sliderContentView.subviews containsObject:view]) {
        [_sliderContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_sliderContentView addSubview:view];
        view.frame = self.sliderView.bounds;
    }
}

- (void)openSliderWithView:(UIView *)view animated:(BOOL)animated
{
    _isSliderOpened = YES;
    [self addViewToSlider:view];
    [self moveSliderToX:0.0f animated:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSliderDidOpened object:nil];
}

- (void)hideSliderAnimated:(BOOL)animated
{
    _isSliderOpened = NO;
    [self moveSliderToX:263.0f animated:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSliderDidClosed object:nil];
}

- (void)moveSliderToX:(CGFloat)xPos animated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^(){
            _sliderView.x = xPos;
        }];
    } else {
        _sliderView.x = xPos;
    }
}

#pragma mark - GestureRecognizer delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (self.presentedViewController != nil) {
        return NO;
    }
    
    if (self.navigationController.viewControllers.count > 1
        && [self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        return NO;
    }
    
    if (gestureRecognizer == _sliderGestureRecognizer &&
        [touch locationInView:self.sliderView].y <= self.view.height) {//44.0) {
        _offset = self.sliderView.x;
        return YES;
    }
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
            return YES;
        }
    }
    
    
    return NO;
}

#pragma mark SliderContentViewControllerDelegate
- (void)sliderContentDidClickMenuButton:(SliderContentViewController *)contentController
{
    if (_isSliderOpened) {
        [self hideSliderAnimated:YES];
    } else {
        [self openSliderWithView:nil animated:YES];
    }
}

- (void)sliderContentTryToPresentViewController:(UIViewController *)viewController
{
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:viewController animated:YES completion:nil];
}
- (void)sliderContentTurnOffGestureRecognizing
{
    _sliderGestureRecognizer.enabled = NO;
}

- (void)sliderContentTurnOnGestureRecognizing
{
    _sliderGestureRecognizer.enabled = YES;
}

@end
