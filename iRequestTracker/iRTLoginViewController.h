//
//  iRTLoginViewController.h
//  iRequestTracker
//
//  Created by Antonio Haley on 12/4/12.
//  Copyright (c) 2012 Antonio Haley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iRTLoginViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *userField;
    IBOutlet UITextField *passField;
    IBOutlet UITextField *uriField;
}

- (IBAction)loginPressed;
- (IBAction)fastLoginPressed;
@end
