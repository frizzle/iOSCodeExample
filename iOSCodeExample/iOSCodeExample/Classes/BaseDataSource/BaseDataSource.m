
#import "BaseDataSource.h"
#import "SectionDescriptionObject.h"
#import <libkern/OSAtomic.h>

@interface BaseDataSource ()

@end

@implementation BaseDataSource

#pragma mark - init/dealloc

- (id)init
{
    self = [super init];
    if (self) {
        _arrayOfSectionDescriptions = [[NSMutableArray alloc] init];
        [self startObserving];
    }
    return self;
}

- (void)dealloc
{
    [self stopObserving];
    _delegate = nil;
}

- (void)startObserving
{
    ;
}

- (void)stopObserving
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadData
{
    NSLog(@"override %@ in %@", NSStringFromSelector(_cmd), [self class]);
}

#pragma mark - Data Source Interface

- (NSUInteger)rowsInSection:(NSUInteger)sectionNum
{
    if (sectionNum < _arrayOfSectionDescriptions.count) {
        SectionDescriptionObject *sectionDescription = [_arrayOfSectionDescriptions objectAtIndex:sectionNum];
        return [sectionDescription rowsCount];
    } else {
        return 0;
    }
}

- (NSUInteger)sectionsCount
{
    return _arrayOfSectionDescriptions.count;
}

- (NSUInteger)dataCount
{
    NSUInteger sections = [self sectionsCount];
    NSUInteger result = 0;
    for (NSUInteger idx = 0; idx < sections; idx++) {
        result += [self rowsInSection:idx];
    }
    return result;
}

- (NSString *)titleForSection:(NSInteger)sectionNum
{
    if (sectionNum < _arrayOfSectionDescriptions.count) {
        SectionDescriptionObject *sectionDescription = [_arrayOfSectionDescriptions objectAtIndex:sectionNum];
        return [sectionDescription sectionTitle];
    } else {
        return nil;
    }
}

- (id)objectForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < [self sectionsCount] && indexPath.row < [self rowsInSection:indexPath.section]) {
        id result = [[(SectionDescriptionObject *)[self.arrayOfSectionDescriptions objectAtIndex:indexPath.section] sectionRows] objectAtIndex:indexPath.row];
        return result;
    } else {
        return nil;
    }
}

- (id)objectForIndex:(NSUInteger)index inSection:(NSUInteger)section
{
    if (section < [self sectionsCount] && index < [self rowsInSection:section]) {
        id result = [[(SectionDescriptionObject *)[self.arrayOfSectionDescriptions objectAtIndex:section] sectionRows] objectAtIndex:index];
        return result;
    } else {
        return nil;
    }
}


@end
