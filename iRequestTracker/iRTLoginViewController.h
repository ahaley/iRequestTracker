//
//  iRTLoginViewController.h
//  iRequestTracker
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
