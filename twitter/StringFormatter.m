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

+ (NSString *) formatRetweets:(NSString *)retweetCount WithFavorites:(NSString *)favoriteCount {
    
    NSString *formattedRetweets = retweetCount.intValue == 0 ? @"NOT RETWEETED " : [retweetCount stringByAppendingString:@" RETWEETS "];
    NSString *formattedFaves =  favoriteCount.intValue == 0 ? @"NOT FAVORITED" : [favoriteCount stringByAppendingString:@" FAVORITES"];
    return [formattedRetweets stringByAppendingString:formattedFaves];
}

@end
