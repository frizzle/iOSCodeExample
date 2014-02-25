
#import "EmergencyPhoneCellView.h"

@implementation EmergencyPhoneCellView

@synthesize phoneData   = _phoneData;

@synthesize phoneButton             = _phoneButton;
@synthesize phoneTitle              = _phoneTitle;
@synthesize phoneNumberLabel        = _phoneNumberLabel;
@synthesize phoneDescriptionLabel   = _phoneDescriptionLabel;
@synthesize informationView         = _informationView;

const CGFloat kEmergencyPhoneCellContentWidth = 240.0f;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.contentView.clipsToBounds = YES;
    self.accessoryView = self.phoneButton;
    self.showsReorderControl = NO;
    self.shouldIndentWhileEditing = NO;
    self.indentationWidth = 0.0f;
    self.indentationLevel = 0;
}

-(void)prepareForReuse
{
    _phoneData = nil;
}

#pragma mark Properties
- (void)setPhoneData:(NSDictionary *)phoneData
{
    _phoneData = phoneData;
    [self reloadInformation];
}

#pragma mark Actions
- (IBAction)phoneButtonClick:(id)sender {
    [_delegate emergencyPhoneCellDidCall:self];
}


#pragma mark Private
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat xShift = SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0") ? - 38.0f : -32.0f;
        
        _informationView.x = editing ? (20.0f + xShift)  : 20.0f;
    }];
}

- (void)reloadInformation
{
    NSString *title         = [_phoneData objectForKey:@"title"];
    NSString *displayNumber = [_phoneData objectForKey:@"display_number"];
    NSString *description   = [_phoneData objectForKey:@"description"];
    NSString *phone_number  = [_phoneData objectForKey:@"phone_number"];
    
    NSString *urlString = [NSString stringWithFormat:@"tel://%@", phone_number];
    NSURL *url = [NSURL URLWithString:urlString];
    
    _phoneButton.hidden = ![[UIApplication sharedApplication] canOpenURL:url];

/*
 some height calculating was deleted
 */
    
    _phoneTitle.text            = title;
    _phoneNumberLabel.text      = displayNumber;
    _phoneDescriptionLabel.text = description;
}

#pragma mark Class methods
+ (CGFloat)cellHeightForPhoneData:(NSDictionary *)phoneData;
{
    CGFloat yPos = 11.0f;
    
    NSString *title         = [phoneData objectForKey:@"title"];
    NSString *displayNumber = [phoneData objectForKey:@"display_number"];
    NSString *description   = [phoneData objectForKey:@"description"];
    
    CGSize maxSize = CGSizeMake(kEmergencyPhoneCellContentWidth, CGFLOAT_MAX);
    
    /*
     some height calculating was deleted
     */

    yPos += 11.0f;

    return yPos;
}


+ (NSString *)cellReuseIdentifier
{
    static NSString *kPhoneCellReuseIdentifier = @"emergencyPhoneCellView";
    return kPhoneCellReuseIdentifier;
}

+ (EmergencyPhoneCellView *)cellInstance
{
    static NSString *kPhoneCellXibName = @"EmergencyPhoneCellView";
    
    EmergencyPhoneCellView *result = nil;
    result = [[[NSBundle mainBundle] loadNibNamed:kPhoneCellXibName owner:nil options:nil] objectAtIndex:0];
    
    return result;
}

@end
