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

+ (NSString *) formatRetweets:(NSString *)retweetCount {
    
    NSString *formattedRetweets = @"";
    if (retweetCount.intValue == 0) {
     formattedRetweets = @" ";
    } else if (retweetCount.intValue == 1) {
        formattedRetweets = [retweetCount stringByAppendingString:@"RETWEET"];
    } else {
        formattedRetweets = [retweetCount stringByAppendingString:@"RETWEETS"];
    }
    return formattedRetweets;
}

+ (NSString *) formatFavorites:(NSString *)favoriteCount {
    
    NSString *formattedFavorites = @"";
    if (favoriteCount.intValue == 0) {
        formattedFavorites = @" ";
    } else if (favoriteCount.intValue == 1) {
        formattedFavorites = [favoriteCount stringByAppendingString:@"FAVORITE"];
    } else {
        formattedFavorites = [favoriteCount stringByAppendingString:@"FAVORITES"];
    }
    return formattedFavorites;
}

@end
