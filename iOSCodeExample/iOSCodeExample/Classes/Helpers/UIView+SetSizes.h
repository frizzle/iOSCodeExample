
#import <UIKit/UIKit.h>


@interface UIView(SetSizes) 

@property(nonatomic) CGFloat x;
@property(nonatomic) CGFloat y;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

- (void)setOrigin:(CGPoint)origin;
- (void)setSize:(CGSize)size;

- (CGFloat)maxY;
- (CGFloat)maxX;

@end
