//
//  TweetDetailsViewController.h
//  twitter
//
//  Created by Bruno Parrinello on 1/24/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetDetailsViewController : UIViewController

@property (nonatomic, strong) Tweet *selectedTweet;
@property (weak, nonatomic) IBOutlet UIImageView *selectedTweetUserImage;
@property (weak, nonatomic) IBOutlet UILabel *selectedTweetUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedTweetUserHandleLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedTweetTimestampLabel;
@property (weak, nonatomic) IBOutlet UITextView *selectedTweetTextView;
@property (weak, nonatomic) IBOutlet UILabel *selectedTweetNumberOfRetweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedTweetNumberOfFavesLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoritesLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectedTweetReplyButton;
@property (weak, nonatomic) IBOutlet UIButton *selectedTweetRetweetButton;
@property (weak, nonatomic) IBOutlet UIButton *selectedTweetFavoriteButton;

@end
