//
//  iRTTicketViewController.m
//  iRequestTracker
//
//  Created by Antonio Haley on 12/2/12.
//  Copyright (c) 2012 Antonio Haley. All rights reserved.
//

#import "iRTTicketViewController.h"
#import "AFNetworking.h"


@interface iRTTicketViewController ()

@end

@implementation iRTTicketViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)parseTicket:(NSString*)ticketString
{
    NSArray *lines =
        [ticketString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    for (NSString* line in lines) {
        
        NSRange range = [line rangeOfString:@":"];
        
        if (range.location == NSNotFound)
            continue;
        NSString *name = [line substringToIndex:range.location];

        NSString *value = [line substringFromIndex:range.location + range.length];
        
        
        
        if ([name isEqualToString:@"Queue"]) {
            queueField.text = value;
        }
        else if ([name isEqualToString:@"Creator"]) {
            creatorField.text = value;
        }
        else if ([name isEqualToString:@"Owner"]) {
            ownerField.text = value;
        }
        else if ([name isEqualToString:@"Created"]) {
            createdField.text = value;
        }
        else if ([name isEqualToString:@"Subject"]) {
            subjectField.text = value;
        }
        else if ([name isEqualToString:@"Status"]) {
            statusField.text = value;
        }
    }
}

- (void)loadTicketId:(NSString*)ticketId
{
    NSString *urlFormat = @"http://rt.cieditions.com/rt/REST/1.0/ticket/%@?user=root&pass=pinhead";
    NSString *urlString = [NSString stringWithFormat:urlFormat, ticketId];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"successful call to RT");
        
        [self parseTicket:operation.responseString];
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
         }];
    
    [operation start];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
