
#import <Foundation/Foundation.h>

@interface SectionDescriptionObject : NSObject

@property (nonatomic, retain) NSMutableArray *sectionRows;
@property (nonatomic, retain) NSString *sectionTitle;

- (NSUInteger)rowsCount;
- (id)initWithTitleString:(NSString *)title rowsArray:(NSMutableArray *)rows;

@end
