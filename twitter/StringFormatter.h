//
//  StringFormatter.h
//  twitter
//
//  Created by Bruno Parrinello on 1/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringFormatter : NSObject

+ (NSString *) twitterHandleFormatter:(NSString *)twitterHandle;

+ (NSString *) formatRetweets:(NSString *)retweetCount;

+ (NSString *) formatFavorites:(NSString *)favoriteCount;

@end
