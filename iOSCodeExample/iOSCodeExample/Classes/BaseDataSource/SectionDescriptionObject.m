
#import "SectionDescriptionObject.h"

@implementation SectionDescriptionObject

- (id)init
{
    self = [super init];
    if (self) {
        _sectionTitle = [[NSString alloc] init];
        _sectionRows = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithTitleString:(NSString *)title rowsArray:(NSMutableArray *)rows
{
    self = [super init];
    if (self) {
        if (title && [title isKindOfClass:[NSString class]]) {
            _sectionTitle = [title copy];
        } else {
            _sectionTitle = [[NSString alloc] init];
        }
        if (rows && [rows isKindOfClass:[NSArray class]]) {
            _sectionRows = [[NSMutableArray alloc] initWithArray:rows];
        } else {
            _sectionRows = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (void)dealloc
{
}

- (NSUInteger)rowsCount
{
    return _sectionRows.count;
}

@end
