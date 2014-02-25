
#import <Foundation/Foundation.h>

@class EmergencyPhoneCellView;

@protocol EmergencyPhoneCellViewDelegate <NSObject>
- (void)emergencyPhoneCellDidCall:(EmergencyPhoneCellView *)phoneCell;
@end
