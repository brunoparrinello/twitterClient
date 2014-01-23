//
//  ComposeTweetViewController.m
//  twitter
//
//  Created by Bruno Parrinello on 1/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ComposeTweetViewController.h"

@interface ComposeTweetViewController ()

- (BOOL)textViewShouldEndEditing:(UITextView *)textView;

@end

@implementation ComposeTweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.composeTweetTextView becomeFirstResponder];
    //self.composeTweetUsernameLabel.text =
}

- (IBAction)onCancelCompose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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