//
//  RequestTracker.h
//  iRequestTracker
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "Ticket.h"

@interface RequestTracker : NSObject
{
    NSString *user_;
    NSString *pass_;
    NSString *url_;
}

- (id)init;

- (id)initWithUser:(NSString*)user andPass:(NSString*)pass;

- (id)initWithUser:(NSString*)user andPass:(NSString*)pass andUrl:(NSString*)url;

- (void)getTicketList:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success;

- (void)getTicket:(NSString*)ticketId
         withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success;

- (void)updateTicket:(Ticket*)ticket;

- (void)createTicket:(Ticket*)ticket;

- (void)closeTicket:(NSString*)ticketId;

@end
