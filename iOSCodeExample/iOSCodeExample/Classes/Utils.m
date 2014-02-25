
#import "Utils.h"

#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import <CoreText/CoreText.h>

#include <objc/runtime.h>
#include <inttypes.h>
#include <Foundation/Foundation.h>

@implementation Utils


+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)sizableImageHorizontlly:(UIImage *)image
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0.0f, image.size.width/2.0f, image.size.height - 1.0f, image.size.width/2.0f);
    return [image resizableImageWithCapInsets:insets];
}

+ (UIImage *)sizableImageVertically:(UIImage *)image
{
    UIEdgeInsets insets = UIEdgeInsetsMake(image.size.height/2.0f, 0.0f, image.size.height/2.0f, image.size.width - 1.0f);
    return [image resizableImageWithCapInsets:insets];
}

+ (UIImage *)sizableImageBothSides:(UIImage *)image
{
    UIEdgeInsets insets = UIEdgeInsetsMake(image.size.height/2.0f, image.size.width/2.0f, image.size.height/2.0f, image.size.width/2.0f);
    return [image resizableImageWithCapInsets:insets];
}


+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    if (fromDateTime == nil || toDateTime == nil) {
        return 0;
    }
    
//    NSDate *fromDate;
//    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];

//    [calendar rangeOfUnit:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit
//                startDate:&fromDate
//                 interval:NULL
//                  forDate:fromDateTime];
//    [calendar rangeOfUnit:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit
//                startDate:&toDate
//                 interval:NULL
//                  forDate:toDateTime];

    NSDateComponents *difference = [calendar components:NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit
                                               fromDate:fromDateTime toDate:toDateTime options:0];
    return [difference day];
}



+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)constrainedSize
{
    CGSize newSize;
    

    CTFontRef fontR = CTFontCreateWithName((CFStringRef)CFBridgingRetain(font.fontName), font.pointSize, NULL);

    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString addAttribute:(NSString*)kCTFontAttributeName
                       value:CFBridgingRelease(fontR)
                       range:NSMakeRange(0, [string length])];

    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attrString);
    newSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, [attrString length]), NULL, constrainedSize, NULL);
    CFRelease(framesetter);
    
    return newSize;
}

+ (NSAttributedString *)attributedStringWithString:(NSString *)string andFont:(UIFont *)font
{
    CTFontRef fontR = CTFontCreateWithName((CFStringRef)CFBridgingRetain(font.fontName), font.pointSize, NULL);
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString addAttribute:(NSString*)kCTFontAttributeName
                       value:CFBridgingRelease(fontR)
                       range:NSMakeRange(0, [string length])];
    return attrString;
};


+ (void)outputRequestParameters:(NSURLRequest *)request
{
    NSString* myString;
    myString = [[NSString alloc] initWithData:request.HTTPBody encoding:NSASCIIStringEncoding];
    NSLog(@"Request URL: %@\nMethod: %@\nBody: %@\nHeader fields: %@", request.URL.absoluteString, request.HTTPMethod, myString,[request allHTTPHeaderFields]);
}

+ (NSString*)formatedPrice:(NSNumber *)price
{
    static NSNumberFormatter *sNumberFormatter = nil;
    
    if (sNumberFormatter == nil)
    {
        sNumberFormatter = [[NSNumberFormatter alloc] init];
        [sNumberFormatter setMaximumFractionDigits:2];
        [sNumberFormatter setMinimumFractionDigits:2];
        [sNumberFormatter setMinimumIntegerDigits:1];
    }
    
    NSString *temp = [sNumberFormatter stringFromNumber:price];
    
    return [temp stringByReplacingOccurrencesOfString:@",00" withString:@",-"];
}


+ (NSTimeZone *)timeZoneOslo
{
    static NSTimeZone *osloTimeZone = nil;
    
    if (osloTimeZone == nil) {
        osloTimeZone = [NSTimeZone timeZoneWithName:@"Europe/Oslo"];
    }
    
    return osloTimeZone;
}

+ (int)getNumberOfPaxFilterItems
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PaxFilterItemsList" ofType:@"plist"];
    NSMutableArray *itemsArray = [NSMutableArray arrayWithContentsOfFile:path];
    
    if (itemsArray != nil) {
        return itemsArray.count;
    }
    
    return 0;
}
@end
