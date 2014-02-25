
#import "BaseDataSource.h"

@interface EmergencyPhonesDataSource : BaseDataSource
{
    NSString *_userResPath;
}

- (void)moveItemAtIndex:(NSInteger)sourceIndex toIndex:(NSInteger)destinationIndex inSection:(NSInteger)section;

@end
