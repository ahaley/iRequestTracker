//
//  iRTTicketViewController.h
//  iRequestTracker
//
//  Created by Antonio Haley on 12/2/12.
//  Copyright (c) 2012 Antonio Haley. All rights reserved.
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
    
    NSString* ticketId_;
}

- (IBAction)saveChanges;
- (void)loadTicketId:(NSString*)ticketId;

@end
