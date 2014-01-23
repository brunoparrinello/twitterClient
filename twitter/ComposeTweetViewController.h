//
//  ComposeTweetViewController.h
//  twitter
//
//  Created by Bruno Parrinello on 1/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeTweetViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *tweetBarButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *cancelComposeBarButton;
@property (weak, nonatomic) IBOutlet UITextView *composeTweetTextView;
@property (weak, nonatomic) IBOutlet UILabel *composeTweetUsernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *composeTweetUserImage;

- (IBAction)onCancelCompose:(id)sender;

@end
