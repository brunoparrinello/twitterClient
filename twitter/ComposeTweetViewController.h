//
//  ComposeTweetViewController.h
//  twitter
//
//  Created by Bruno Parrinello on 1/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeTweetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationItem *tweetBarButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *cancelComposeBarButton;
- (IBAction)onCancelCompose:(id)sender;

@end
