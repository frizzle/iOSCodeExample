
#import "EmergencyPhonesDataSource.h"
#import "SectionDescriptionObject.h"

@implementation EmergencyPhonesDataSource

//In case of changes if you need to update user list increase index at the end of the constant value
static NSString * const kUserDefaultsEmergencyPhonesNeedToUpdate = @"keyUserDefaultsEmergencyPhonesNeedToUpdate_1";

- (id)init
{
    self = [super init];
    
    if (self != nil) {
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        _userResPath = [NSString stringWithFormat:@"%@/EmergencyPhonesList_%@",
                                      documentsDirectory,
                                        @"some_user_identifier"];
    }
    
    return self;
}

- (void)loadData
{
    NSFileManager *fmngr = [[NSFileManager alloc] init];
    
    NSString *userResourcePath = _userResPath;
    
    [self checkIfPhonesNeedsToUpdate];
    
    //If there is no copied instance of phones list for current user we create copy 
    if (![fmngr fileExistsAtPath:userResourcePath]) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"EmergencyPhonesList" ofType:@"plist"];
        NSError *error;
        if(![fmngr copyItemAtPath:filePath toPath:userResourcePath error:&error]) {
            NSLog(@"Error creating local phones list: %@", [error description]);
            userResourcePath = filePath;
        }
    }
    
    NSMutableArray *phonesArray = [NSMutableArray arrayWithContentsOfFile:userResourcePath];
    
    SectionDescriptionObject *section = [[SectionDescriptionObject alloc] initWithTitleString:nil rowsArray:phonesArray];
    [self.arrayOfSectionDescriptions addObject:section];
    
    [self.delegate dataSourceDidFinishLoading];
}

- (void)checkIfPhonesNeedsToUpdate
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsEmergencyPhonesNeedToUpdate] == nil) {
        NSFileManager *fmngr = [[NSFileManager alloc] init];
        if ([fmngr fileExistsAtPath:_userResPath]) {
            NSError *error = nil;
            [fmngr removeItemAtPath:_userResPath error:&error];
            
            if (error == nil) {
                [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES ] forKey:kUserDefaultsEmergencyPhonesNeedToUpdate];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    }
}

- (void)moveItemAtIndex:(NSInteger)sourceIndex toIndex:(NSInteger)destinationIndex inSection:(NSInteger)section
{
    if (section >= self.sectionsCount) {
        return;
    }
    
    SectionDescriptionObject *sectionObject = [self.arrayOfSectionDescriptions objectAtIndex:section];
    
    if (sourceIndex > sectionObject.rowsCount || destinationIndex > sectionObject.rowsCount) {
        return;
    }
    
    id object = [sectionObject.sectionRows objectAtIndex:sourceIndex];
    
    [sectionObject.sectionRows removeObjectAtIndex:sourceIndex];
    [sectionObject.sectionRows insertObject:object atIndex:destinationIndex];
    
    [sectionObject.sectionRows writeToFile:_userResPath atomically:YES];
}

@end
