
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

typedef NS_ENUM(NSInteger, DateInThePastDistance) {
    DateInThePastDistanceToday,
    DateInThePastDistanceYesterday,
    DateInThePastDistanceOther
};

@interface Utils : NSObject
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIImage *)sizableImageHorizontlly:(UIImage *)image;
+ (UIImage *)sizableImageVertically:(UIImage *)image;
+ (UIImage *)sizableImageBothSides:(UIImage *)image;

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;


+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)constrainedSize;
+ (NSAttributedString *)attributedStringWithString:(NSString *)string andFont:(UIFont *)font;

+ (void)outputRequestParameters:(NSURLRequest *)request;

+ (NSString*)formatedPrice:(NSNumber *)price;

+ (NSTimeZone *)timeZoneOslo;

+ (int)getNumberOfPaxFilterItems;

@end
