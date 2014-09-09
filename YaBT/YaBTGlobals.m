#import "YaBTGlobals.h"

NSString* const YaBTErrorDomain = @"YaBTErrorDomain" ;

NSString* DemoTimestamp() {
    // After spending 45 minutes reading NSDateFormatter trying to
    // figure out a non-depracated and supported way to get a date
    // in geek format, I noticed that -[NSDate description] is
    // *documented* to return a string in this format:
    //     YYYY-MM-DD HH:MM:SS ±HHMM
    // Prior to Mac OS 10.7, ±HHMM = the local time zone offset
    // Starting in Mac OS 10.7, ±HHMM = +0000.
    // We want the time in the local time zone, so we need to read and adjust if necessary
    // To find "if necessary", we determine whether or not ±HHMM is equal to the
    // local time offset.  If it is, no adjustment is necessary.
    NSDate* now = [NSDate date] ;
    NSString* s = [now description] ;
    NSInteger tzSign = [[s substringWithRange:NSMakeRange(20,1)] isEqualToString:@"+"] ? +1 : -1 ;
    NSInteger tzHours = [[s substringWithRange:NSMakeRange(21,2)] integerValue] ;
    NSInteger tzMinutes = [[s substringWithRange:NSMakeRange(23,2)] integerValue] ;
    NSInteger tzSeconds = tzSign * (3600*tzHours + 60*tzMinutes) ;
    NSInteger localTzSeconds = [[NSTimeZone localTimeZone] secondsFromGMT] ;
    NSString* localTimeString ;
    NSTimeInterval adjustment = localTzSeconds - tzSeconds ;
    // We'd rather not make the adjustment, because -dateByAddingTimeInterval:
    // is not available in Mac OS X 10.5.  And since we're going to ignore the
    // seconds anyhow, we allow 30 seconds of slop.
    if (fabs(adjustment) < 30.0) {
        // This must be Mac OS 10.5 or 10.6.  No adjustment is necessary.
        localTimeString = s ;
    }
    else {
        // This must be Mac OS 10.7.  Must adjust.
        // Fortunately, starting in Mac OS 10.6 we have -[NSDate dateByAddingTimeInterval]
        NSDate* localDate = [now dateByAddingTimeInterval:(adjustment)] ;
        localTimeString = [localDate description] ;
    }
    
    s = [[localTimeString substringToIndex:19] substringFromIndex:11] ;
    
    return s ;
}

