
#import "EmergencyPhoneCellViewDelegate.h"

@interface EmergencyPhoneCellView : UITableViewCell

@property (nonatomic, strong) NSDictionary *phoneData;
@property (nonatomic, weak) id<EmergencyPhoneCellViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton   *phoneButton;
@property (weak, nonatomic) IBOutlet UILabel    *phoneTitle;
@property (weak, nonatomic) IBOutlet UILabel    *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel    *phoneDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIView     *informationView;

- (IBAction)phoneButtonClick:(id)sender;

+ (CGFloat)cellHeightForPhoneData:(NSDictionary *)phoneData;
+ (NSString *)cellReuseIdentifier;
+ (EmergencyPhoneCellView *)cellInstance;

@end
