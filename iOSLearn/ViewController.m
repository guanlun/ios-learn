//
//  ViewController.m
//  iOSLearn
//
//  Created by Guanlun Zhao on 11/26/13.
//  Copyright (c) 2013 Guanlun Zhao. All rights reserved.
//

#import "ViewController.h"
#import "TopicListViewController.h"
#import "Classes/SBJsonParser.h"
#import "PostileHttpHandler.h"

@import AVFoundation;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property NSMutableArray *parserdData;

@end

@implementation ViewController

@synthesize loginField;
@synthesize passwordField;

@synthesize parserdData;

- (IBAction)signinButton:(id)sender
{
    NSString *login = loginField.text;
    NSString *password = passwordField.text;
    
    if ([login length] && [password length]) {
        [self sendRequestWithLogin:login Password:password];
    }
}

- (void)sendRequestWithLogin:(NSString *)login Password:(NSString *)password
{
    NSString *url = @"http://postiles.com:3000/user/login";
    NSMutableDictionary *postDict = [[NSMutableDictionary alloc] init];
    [postDict setObject:login forKey:@"username"];
    [postDict setObject:password forKey:@"password"];
    
    NSDictionary *data = [PostileHttpHandler sendRequestToURL:url WithData:postDict];
    
    if ([[data objectForKey:@"status"] isEqualToString:@"ok"]) {
        TopicListViewController *second = [self.storyboard instantiateViewControllerWithIdentifier:@"TopicListViewController"];
        [self.navigationController pushViewController:second animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed"
                                                        message:@"Incorrect login or password"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
}

@end
