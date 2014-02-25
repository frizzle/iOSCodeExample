

#ifndef TappticTestApp_AZMacroses_h
#define TappticTestApp_AZMacroses_h

#pragma mark - Application name 

/*
 * get application name
 */
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]


/*
 * memory management (ARC/non-ARC)
 */

#pragma mark - memory management macroses (ARC/non-ARC)

#if !__has_feature(objc_arc)

#pragma mark - NON-ARC memory management macroses

/*
 * memory management
 */

    #define SAFE_RELEASE_AND_NIL(__TARGET__)        {[(__TARGET__) release]; (__TARGET__) = nil;}
    #define SAFE_RELEASE(__TARGET__)                {[(__TARGET__) release];}
    #define SAFE_RETAIN(__TARGET__)                 ([(__TARGET__) retain])
    #define SAFE_RETAIN_AUTORELEASE(__TARGET__)     ([[(__TARGET__) retain] autorelease])
    #define SAFE_COPY_AUTORELEASE(__TARGET__)       ([[(__TARGET__) copy] autorelease])
    #define SAFE_AUTORELEASE(__TARGET__)            ([(__TARGET__) autorelease])
    #define SAFE_SUPER_DEALLOC_CALL()               {if ([super respondsToSelector:@selector(dealloc)]) {[super dealloc];}}

/*
 * property qualifiers
 */

    #define PROPERTY_STRONG_TYPE                             retain
    #define PROPERTY_WEAK_TYPE                               assign

/*
 * storage qualifiers
 */

    #define OBJ_WEAK
    #define OBJ_STRONG
    #define OBJ_UNSAFE_UNRETAINED
    #define OBJ_AUTORELEASING

/*
 * bridged casts
 */

    #define CAST_BRIDGE
    #define CAST_BRIDGE_RETAINED
    #define CAST_BRIDGE_TRANSFER
#else

#pragma mark - ARC memory management macroses

/*
 * memory management
 */

#define SAFE_RELEASE_AND_NIL(__TARGET__)        {(__TARGET__) = nil;}
#define SAFE_RELEASE(__TARGET__)                
#define SAFE_RETAIN(__TARGET__)                 (__TARGET__)
#define SAFE_RETAIN_AUTORELEASE(__TARGET__)     (__TARGET__)
#define SAFE_COPY_AUTORELEASE(__TARGET__)       ([(__TARGET__) copy])
#define SAFE_AUTORELEASE(__TARGET__)            (__TARGET__)
#define SAFE_SUPER_DEALLOC_CALL()
/*
 * property qualifiers
 */

    #define PROPERTY_STRONG_TYPE                             strong
    #define PROPERTY_WEAK_TYPE                               weak

/*
 * storage qualifiers
 */

    #define OBJ_WEAK __weak
    #define OBJ_STRONG __strong
    #define OBJ_UNSAFE_UNRETAINED __unsafe_unretained
    #define OBJ_AUTORELEASING __autoreleasing

/*
 * bridged casts
 */

    #define CAST_BRIDGE __bridge
    #define CAST_BRIDGE_RETAINED __bridge_retained
    #define CAST_BRIDGE_TRANSFER __bridge_transfer
#endif

/*
 * synthesize
 */

#pragma mark - synthesize macroses

#define SYNTHESIZE(__PROPERTY__)                    @synthesize __PROPERTY__ = _##__PROPERTY__;

/*
 * localization
 */

#pragma mark - localization macroses

#define LOC(key)                                    NSLocalizedStringWithDefaultValue((key), nil, [NSBundle mainBundle], @" ", nil)

/*
 * logging
 */

#pragma mark - logging macroses

#define LogStringFromRect(__RECT__)                 [NSString stringWithFormat:@"%s = %@", #__RECT__, NSStringFromCGRect(__RECT__)]
#define LogStringFromSize(__SIZE__)                 [NSString stringWithFormat:@"%s = %@", #__SIZE__, NSStringFromCGSize(__SIZE__)]
#define LogStringFromPoint(__POINT__)               [NSString stringWithFormat:@"%s = %@", #__POINT__, NSStringFromCGPoint(__POINT__)]
#define LogStringFromBOOL(__BOOL__)                 [NSString stringWithFormat:@"%s = %@", #__BOOL__, __BOOL__ ? @"YES" : @"NO"]

#define ERROR_TO_LOG(__FORMAT__...)                 {NSString *__ERROR_STRING__ = [NSString stringWithFormat:__FORMAT__]; NSLog(@"ERROR::%s:%@", __func__, __ERROR_STRING__);}

#if defined(SHOW_WARNINGS) && SHOW_WARNINGS
#define WARNING_TO_LOG(__FORMAT__...)               {NSString *__WARNING_STRING__ = [NSString stringWithFormat:__FORMAT__]; NSLog(@"WARNING::%s:%@", __func__, __WARNING_STRING__);}
#else
#define WARNING_TO_LOG(__FORMAT__...)               
#endif

#ifdef DEBUG
    #define DEBUG_LOG(__FORMAT__...)                {NSString *__DEBUG_STRING__ = [NSString stringWithFormat:__FORMAT__]; NSLog(@"DEBUG IN FUNCTION \'%s\' ON LINE \'%d\' :: Class [%@] called \'%@\', debug message:\"%@\"", __func__, __LINE__, [self class], NSStringFromSelector(_cmd), __DEBUG_STRING__);}
#else
    #define DEBUG_LOG(__FORMAT__...)
#endif


/*
 * OS version defining
 */
#pragma mark - OS Version macroses

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#endif
