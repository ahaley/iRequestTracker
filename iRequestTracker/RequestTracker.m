//
//  RequestTracker.m
//  iRequestTracker
//
//  Created by Aditya Burkule on 12/2/12.
//  Copyright (c) 2012 Aditya Burkule. All rights reserved.
//

#import "RequestTracker.h"
#import "AFNetworking.h"
#import "Ticket.h"

@implementation RequestTracker

- (id)init
{
    self = [super init];
    if (self) {
        url_ = @"http://rt.cieditions.com/rt/REST/1.0";
        user_ = @"root";
        pass_ = @"pinhead";
    }
    return self;
}

- (id)initWithUser:(NSString*)user andPass:(NSString*)pass
{
    self = [super init];
    if (self) {
        user_ = user;
        pass_ = pass;
        url_ = @"http://rt.cieditions.com/rt/REST/1.0";
    }
    return self;
}

- (id)initWithUser:(NSString*)user andPass:(NSString*)pass andUrl:(NSString*)url
{
    self = [super init];
    if (self) {
        user_ = user;
        pass_ = pass;
        url_ = url;
    }
    return self;
}

- (void)getTicketList:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
{
    NSURL *url = [self getListUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:success
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                                     }];
    [operation start];
}

- (void)getTicket:(NSString*)ticketId
         withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
{
    NSURL *url = [self getTicketUrl:ticketId];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:success
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                                     }];
    [operation start];
}

- (void)updateTicket:(Ticket*)ticket
{
    NSURL* url = [self getUpdateUrl:ticket.ticketId];
    NSString *body = [NSString stringWithFormat:
                @"content=Subject: %@\nOwner: %@", ticket.subject, ticket.owner];
    
    
    [self postTicket:url withBody:body];
}

- (void)createTicket:(Ticket*)ticket
{
    NSURL* url = [self getInsertUrl];
    NSString *body = [NSString stringWithFormat:
        @"content=Queue: General\nOwner: %@\nSubject: %@",
                      ticket.owner, ticket.subject];
    [self postTicket:url withBody:body];
}

- (void)closeTicket:(NSString*)ticketId
{
    NSURL* url = [self getUpdateUrl:ticketId];
    NSString *body = @"content=Status: Resolved";
    [self postTicket:url withBody:body];
}

- (NSURL*)getListUrl
{
    return [[NSURL alloc] initWithString:
            [NSString stringWithFormat:@"%@/search/ticket?query=Queue='General'AND'Owner'='%@'&user=%@&pass=%@",
                url_,
                user_,
                user_,
                pass_]];
}

- (NSURL*)getTicketUrl:(NSString*)ticketId
{
    return [[NSURL alloc] initWithString:
            [NSString stringWithFormat:@"%@/ticket/%@?user=%@&pass=%@",
             url_, ticketId, user_, pass_]];
}

- (NSURL*)getUpdateUrl:(NSString*)ticketId
{
    return [[NSURL alloc] initWithString:
            [NSString stringWithFormat:@"%@/ticket/%@/edit?user=%@&pass=%@",
             url_, ticketId, user_, pass_]];
}

- (NSURL*)getInsertUrl
{
    return [[NSURL alloc] initWithString:
            [NSString stringWithFormat:@"%@/ticket/new?user=%@&pass=%@",
             url_, user_, pass_]];
}

- (void)postTicket:(NSURL*)url withBody:(NSString*)body
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Success" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [message show];
        
        NSLog(@"successful call to RT, response = %@", operation.responseString);
    }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                                     }];
    
    [operation start];

}


@end
