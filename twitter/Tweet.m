//
//  Tweet.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (NSString *)tweetId {
    return [self.data valueOrNilForKeyPath:@"id_str"];
}

- (NSString *)text {
    return [self.data valueOrNilForKeyPath:@"text"];
}

- (NSString *)username {
    return [self.data valueOrNilForKeyPath:@"user.name"];
}

- (NSString *)userHandle {
    return [self.data valueOrNilForKeyPath:@"user.screen_name"];
}

- (NSString *)userImageURL {
    return [NSURL URLWithString:[self.data valueOrNilForKeyPath:@"user.profile_image_url"]];
}

- (NSString *)tweetTimestamp {
    return [self.data valueOrNilForKeyPath:@"created_at"];
}

- (NSString *)numberOfRetweets {
    NSString *stringRetweets = [NSString stringWithFormat:@"%@", [self.data valueOrNilForKeyPath:@"retweet_count"]];
    return stringRetweets;
}

- (NSString *)numberOfFavorites {
    NSString *stringFavorites = [NSString stringWithFormat:@"%@", [self.data valueOrNilForKeyPath:@"favorite_count"]];
    return stringFavorites;
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}

@end
