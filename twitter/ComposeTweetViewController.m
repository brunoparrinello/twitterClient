//
//  ComposeTweetViewController.m
//  twitter
//
//  Created by Bruno Parrinello on 1/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ComposeTweetViewController.h"
#import "StringFormatter.h"

@interface ComposeTweetViewController ()

- (BOOL)textViewShouldEndEditing:(UITextView *)textView;

- (IBAction)onCancelCompose:(id)sender;
- (IBAction)onTweet:(id)sender;
//- (void)onCancelCompose;
//- (void)onTweet;


@end

@implementation ComposeTweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Compose Tweet";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelCompose:)];
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelCompose:)];
    
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet!" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet:)];
    
    // Do any additional setup after loading the view from its nib.
    [self.composeTweetTextView becomeFirstResponder];

    // Populate signed in user info
    User *signedInUser = [User currentUser];
    NSString *handle = [StringFormatter twitterHandleFormatter:signedInUser.currentUserHandle];
    self.composeTweetUsernameLabel.text = signedInUser.currentUsername;
    self.composeTweetUserHandle.text = handle;
    
    NSData * imageData = [NSData dataWithContentsOfURL:signedInUser.currentUserImageURL];
    [self.composeTweetUserImage setImage:[UIImage imageWithData:imageData]];
}

- (IBAction)onCancelCompose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onTweet:(id)sender {
    
    NSLog(@"Tweet Button has been clicked");
    //TODO: Tweet
    [[TwitterClient instance] updateStatus:self.composeTweetTextView.text success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        //self.tweets = [Tweet tweetsWithArray:response];
        //[self.tableView reloadData];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Do nothing
    }];
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
