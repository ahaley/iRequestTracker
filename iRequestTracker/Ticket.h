//
//  iRTTicket.h
//  iRequestTracker
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject
{
    NSString *ticketId_;
    NSString *queue_;
    NSString *owner_;
    NSString *creator_;
    NSString *subject_;
    NSString *status_;
    NSString *created_;
}

@property (nonatomic,copy) NSString *ticketId;
@property (nonatomic,copy) NSString *queue;
@property (nonatomic,copy) NSString *owner;
@property (nonatomic,copy) NSString *creator;
@property (nonatomic,copy) NSString *subject;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *created;


@end
