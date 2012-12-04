//
//  iRTTicketViewController.h
//  iRequestTracker
//
//  Created by Aditya Burkule on 12/2/12.
//  Copyright (c) 2012 Aditya Burkule. All rights reserved.
//

#import <UIKit/UIKit.h>

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
}

- (IBAction)saveChanges;
- (IBAction)closeTicket;
- (void)loadTicketId:(NSString*)ticketId;
- (void)setNew;

@end
