
#import <Foundation/Foundation.h>

@protocol TableViewDataSourceProtocol <NSObject>
@required
- (void)dataSourceDidFinishLoading;
@optional
- (void)dataSourceGotData;

@end


@interface BaseDataSource : NSObject

@property (nonatomic, weak) id<TableViewDataSourceProtocol>delegate;
@property (nonatomic, strong) NSMutableArray *arrayOfSectionDescriptions;

- (void)stopObserving;

- (NSUInteger)rowsInSection:(NSUInteger)sectionNum;
- (NSUInteger)sectionsCount;
- (NSUInteger)dataCount;
- (NSString *)titleForSection:(NSInteger)sectionNum;
- (id)objectForIndexPath:(NSIndexPath *)indexPath;
- (id)objectForIndex:(NSUInteger)index inSection:(NSUInteger)section;


/*
 * Subclusses CAN override these methods
 */

- (void)loadData;


/*
 * Subclusses should override this method if they want to subscribe to some notifications
 */

- (void)startObserving;

@end
