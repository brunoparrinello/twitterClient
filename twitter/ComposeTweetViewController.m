//
//  ComposeTweetViewController.m
//  twitter
//
//  Created by Bruno Parrinello on 1/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ComposeTweetViewController.h"
#import "StringFormatter.h"
#import "UIImageView+AFNetworking.h"
#import "TimelineVC.h"

#define TWITTER_STATUS_MAX_LENGTH 140

@interface ComposeTweetViewController ()

- (BOOL)textViewShouldEndEditing:(UITextView *)textView;

- (void)onCancelCompose;
- (void)onTweet;


@end

@implementation ComposeTweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelCompose)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet!" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet)];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        NSLog(@"Load resources for iOS 6.1 or earlier");
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    } else {
        NSLog(@"Load resources for iOS 7 or later");
        // Setting to twitter-like color
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.33 green:0.67 blue:0.93 alpha:1.0];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self.composeTweetTextView becomeFirstResponder];

    // Populate signed in user info
    User *signedInUser = [User currentUser];
    NSString *handle = [StringFormatter twitterHandleFormatter:signedInUser.currentUserHandle];
    self.composeTweetUsernameLabel.text = signedInUser.currentUsername;
    self.composeTweetUserHandle.text = handle;
    [self.composeTweetUserImage setImageWithURL:signedInUser.currentUserImageURL];
    if (self.replyingToTweet) {
        self.composeTweetTextView.text = [[StringFormatter twitterHandleFormatter:self.replyingToTweet.userHandle] stringByAppendingString:@" "];
    } else {
        self.composeTweetTextView.clearsOnInsertion = YES;
    }
    self.charCounterLabel.text = [NSString stringWithFormat:@"%d", (TWITTER_STATUS_MAX_LENGTH - self.composeTweetTextView.text.length)];
}

- (void)textViewDidChange:(UITextView *)textView {
    int remainingChars = (TWITTER_STATUS_MAX_LENGTH - self.composeTweetTextView.text.length);
    self.charCounterLabel.text = [NSString stringWithFormat:@"%d", remainingChars];
    if (remainingChars <= 10) {
        self.charCounterLabel.textColor = [UIColor redColor];
    } else {
        self.charCounterLabel.textColor = [UIColor blackColor];
    }
//    if (remainingChars < 0) {
//        [self.tweetBarButton setEnabled:NO];
//    } else if (remainingChars >= 0) {
//        [self.tweetBarButton setEnabled:YES];
//    }
}

- (void)onCancelCompose {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onTweet {
    
    if (self.replyingToTweet) {
        [[TwitterClient instance] replyToTweet:self.composeTweetTextView.text inReplyTo:self.replyingToTweet.tweetId success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"Replying to tweet - Response: %@", response);
            
            [self dismissViewControllerAnimated:YES completion:nil];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            // Do nothing
            NSLog(@"Failure encountered during reply: %d - %@",error.code, error.description);
        }];
    } else {

    [[TwitterClient instance] updateStatus:self.composeTweetTextView.text success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"Tweeting! - Response: %@", response);
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Do nothing
        NSLog(@"Failure encountered during tweet: %d - %@",error.code, error.description);
    }];
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [self.view endEditing:YES];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
