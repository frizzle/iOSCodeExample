
#import <Foundation/Foundation.h>

@class MenuBarButtonItem;

@protocol MenuBarButtonItemDelegate <NSObject>

- (void)menuItemDidClickMenu:(MenuBarButtonItem *)menuBarItem;
- (void)menuItemDidClickBack:(MenuBarButtonItem *)menuBarItem;


@end
