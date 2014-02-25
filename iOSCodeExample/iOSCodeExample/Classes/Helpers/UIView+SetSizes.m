
#import "UIView+SetSizes.h"


@implementation UIView(SetSizes)

- (void)setOrigin:(CGPoint)origin
{
	CGRect selfFrame = self.frame;
	selfFrame.origin = origin;
	self.frame = selfFrame;
}

-(void)setSize:(CGSize)size
{
    CGRect selfFrame = self.frame;
	selfFrame.size = size;
	self.frame = selfFrame;
}

- (void)setX: (CGFloat)x
{
	CGRect seflFrame = self.frame;
	seflFrame.origin.x = x;
	self.frame = seflFrame;
}

- (void)setY:(CGFloat)y
{
	CGRect seflFrame = self.frame;
	seflFrame.origin.y = y;
	self.frame = seflFrame;
}

- (void) setWidth: (CGFloat) width
{
	CGRect seflFrame = self.frame;
	seflFrame.size.width = width;
	self.frame = seflFrame;
}

- (void) setHeight: (CGFloat) height
{
	CGRect seflFrame = self.frame;
	seflFrame.size.height = height;
	self.frame = seflFrame;
}

- (CGFloat)x
{
	return self.frame.origin.x;
}

- (CGFloat)y
{
	return self.frame.origin.y;
}

- (CGFloat) width
{
	return self.frame.size.width;
}

- (CGFloat) height
{
	return self.frame.size.height;
}

- (CGFloat)maxY
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)maxX
{
    return self.frame.origin.x + self.frame.size.width;

}

@end
