//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Bruno Parrinello on 1/24/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "Tweet.h"

@interface TweetDetailsViewController ()

- (IBAction)onRetweet:(id)sender;

@end

@implementation TweetDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tweet";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        NSLog(@"Load resources for iOS 6.1 or earlier");
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
    } else {
        NSLog(@"Load resources for iOS 7 or later");
        self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    }
    
    // Do any additional setup after loading the view from its nib.
    self.selectedTweetUsernameLabel.text = self.selectedTweet.username;
    self.selectedTweetUserHandleLabel.text = [StringFormatter twitterHandleFormatter:self.selectedTweet.userHandle];
    self.selectedTweetTimestampLabel.text = self.selectedTweet.tweetTimestamp;
    self.selectedTweetTextView.text = self.selectedTweet.text;
    //TODO: Add image info
    
}

- (IBAction)onRetweet:(id)sender {
    NSLog(@"Retweet Button has been clicked");
    [[TwitterClient instance] retweet:self.selectedTweet.tweetId success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        //TODO: Add Action to indicate that the retweet action worked.
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Do nothing
        NSLog(@"Retweet has failed: %d - %@", error.code, error.description);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
