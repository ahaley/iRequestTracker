//
//  iRTTicketViewController.m
//  iRequestTracker
//

#import "iRTTicketViewController.h"
#import "AFNetworking.h"
#import "Ticket.h"
#import "RequestTracker.h"

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

- (void)setNew
{
    [submitButton setTitle:@"Create Ticket" forState:UIControlStateNormal];
}

- (void)viewDidDisappear:(BOOL)animated
{
    subjectField.text = @"";
    createdField.text = @"";
    creatorField.text = @"";
    ownerField.text = @"";
    queueField.text = @"";
    statusField.text = @"";
    ticketId_ = nil;
}

- (void)setRequestTracker:(RequestTracker *)requestTracker
{
    requestTracker_ = requestTracker;
}

- (RequestTracker*)requestTracker
{
    if (requestTracker_ == nil) {
        requestTracker_ = [[RequestTracker alloc] init];
    }
    return requestTracker_;
}

- (void)closeTicket
{
    if (ticketId_ == nil) {
        return;
    }
    
    RequestTracker *tracker = [self requestTracker];
    [tracker closeTicket:ticketId_];
}

- (IBAction)saveChanges
{
    NSLog(@"Save Changes!");
    
    RequestTracker *tracker = [self requestTracker];
    Ticket* ticket = [[Ticket alloc] init];
    
    ticket.queue = queueField.text;
    ticket.created = createdField.text;
    ticket.creator = creatorField.text;
    ticket.status = statusField.text;
    ticket.subject = subjectField.text;
    ticket.owner = ownerField.text;
    
    if (ticketId_ != nil) {
        ticket.ticketId = ticketId_;
        [tracker updateTicket:ticket];
    }
    else {
        [tracker createTicket:ticket];
    }
}

//Close keyboard after hitting return
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
   /*
            if ([value isEqualToString:@" Resolved"]) {
                [closeTicketButton setTitle:@"Reopen Ticket" forState:UIControlStateNormal];
            }
            else if ([value isEqualToString:@"new"]) {
                [closeTicketButton setTitle:@"Close Ticket" forState:UIControlStateNormal];
            }
    */
        }
    
    }
    
}

- (void)loadTicketId:(NSString*)ticketId
{
    ticketId_ = ticketId;
    
    RequestTracker *tracker = [self requestTracker];
    
    [tracker getTicket:ticketId withSuccess: ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"successful call to RT");
        [self parseTicket:operation.responseString];
    }];

    [submitButton setTitle:@"Save Changes" forState:UIControlStateNormal];
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
