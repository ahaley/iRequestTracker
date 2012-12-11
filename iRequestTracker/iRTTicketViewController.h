//
//  iRTTicketViewController.h
//  iRequestTracker
//

#import <UIKit/UIKit.h>
#import "RequestTracker.h"

@interface iRTTicketViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *queueField;
    IBOutlet UITextField *ownerField;
    IBOutlet UITextField *creatorField;
    IBOutlet UITextField *createdField;
    IBOutlet UITextField *statusField;
    IBOutlet UITextField *subjectField;
    IBOutlet UIButton *submitButton;
    IBOutlet UIButton *closeTicketButton;
    
    NSString* ticketId_;
    RequestTracker* requestTracker_;
}

@property (nonatomic, retain) RequestTracker* requestTracker;

- (IBAction)saveChanges;
- (IBAction)closeTicket;
- (void)loadTicketId:(NSString*)ticketId;
- (void)setNew;

@end
