//
//  RequestTracker.h
//  iRequestTracker
//
//  Created by Aditya Burkule on 12/2/12.
//  Copyright (c) 2012 Aditya Burkule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "Ticket.h"

@interface iRTLoginController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *userField;
    IBOutlet UITextField *passField;
    IBOutlet UIButton *loginButton;
    
}
@end

@interface RequestTracker : NSObject
{
    NSString *user_;
    NSString *pass_;
    NSString *url_;
    NSString *owner_;
}

- (id)init;

- (id)initWithUser:(NSString*)user andPass:(NSString*)pass andOwner:(NSString*)owner andUrl:(NSString*)url;

- (void)getTicketList:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success;

- (void)getTicket:(NSString*)ticketId
         withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success;

- (void)updateTicket:(Ticket*)ticket;

- (void)createTicket:(Ticket*)ticket;

- (void)closeTicket:(NSString*)ticketId;

- (IBAction)Login;


@end
