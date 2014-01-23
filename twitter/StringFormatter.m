//
//  StringFormatter.m
//  twitter
//
//  Created by Bruno Parrinello on 1/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "StringFormatter.h"

@implementation StringFormatter

+ (NSString *) twitterHandleFormatter:(NSString *)twitterHandle {
    return [@"@" stringByAppendingString:twitterHandle];
}

@end
