//
//  TimelineVC.m
//  twitter
//
//  Created by Timothy Lee on 8/4/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TimelineVC.h"
#import "TweetCell.h"
#import "ComposeTweetViewController.h"
#import "StringFormatter.h"
#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface TimelineVC ()

@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, strong) Tweet *tweetedStatus;

- (void)onSignOutButton;
- (void)onComposeButton;
- (void)reload;

@end

@implementation TimelineVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Home";
        
        [self reload];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"View will appear");
    [super viewWillAppear:animated];
    // set navigation bar's tint color when being shown
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // Load resources for iOS 6.1 or earlier
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    } else {
        // Load resources for iOS 7 or later
        // Setting to twitter-like color
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.33 green:0.67 blue:0.93 alpha:1.0];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    }
}

- (void)viewDidLoad
{
    NSLog(@"View did load");
    [super viewDidLoad];
    
    // Register the custom tweet cell
    UINib *tweetCellNib = [UINib nibWithNibName:@"TweetCell" bundle:nil];
    [self.tableView registerNib:tweetCellNib forCellReuseIdentifier:@"TweetCell"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOutButton)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStylePlain target:self action:@selector(onComposeButton)];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TweetCell Version
    static NSString *CellIdentifier = @"TweetCell";
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Initial Version
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    Tweet *tweet = self.tweets[indexPath.row];
    cell.tweetUsernameLabel.text = tweet.username;
    cell.tweetContentTextView.text = tweet.text;
    cell.tweetTimestampLabel.text = tweet.tweetTimestamp;
    cell.tweetUserHandle.text = [StringFormatter twitterHandleFormatter:tweet.userHandle];
    [cell.tweetUserProfileImage setImageWithURL:tweet.userImageURL];
    cell.tweetContentLabel.text = tweet.text;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Tweet *tweet = self.tweets[indexPath.row];
    
    // Setting the max width based on the size of the screen
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 50;
    CGFloat maxHeight = 9999;
    CGSize maximumLabelSize = CGSizeMake(maxWidth,maxHeight);
    CGSize expectedTweetSize = [tweet.text sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    
    // 37 is the size of the label height (22) + size of padding top and bottom (8 each)
    // 59 is the size of the image height (45) + size of padding top and bottom (7 each)
    float minHeight = 59.0;
    float labelHeightPlusPadding = 31.0;
    float diffHeight = ((labelHeightPlusPadding + expectedTweetSize.height) - minHeight);
    // Evaluating the height of the image + padding vs label + padding
    // Calculating the height difference, to make sure the cell does not truncate the image, and account for the label height
    diffHeight = ( diffHeight > 0) ? diffHeight : 0;
    float cellHeight = minHeight + diffHeight;
    
    return cellHeight;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Tweet *selectedTweet = self.tweets[indexPath.row];
    TweetDetailsViewController *tdvc = [[TweetDetailsViewController alloc] init];
    tdvc.selectedTweet = selectedTweet;
    [self.navigationController pushViewController:tdvc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma mark - Private methods

- (void)onSignOutButton {
    [User setCurrentUser:nil];
}

- (void)onComposeButton {
    ComposeTweetViewController *vc = [[ComposeTweetViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self.navigationController presentViewController:nvc animated:YES completion:nil];
}

- (void)reload {
    [[TwitterClient instance] homeTimelineWithCount:20 sinceId:0 maxId:0 success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        self.tweets = [Tweet tweetsWithArray:response];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Do nothing
    }];
}

@end
