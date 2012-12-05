//
//  iRTLoginViewController.m
//  iRequestTracker
//
//  Created by Aditya Burkule on 12/4/12.
//  Copyright (c) 2012 Aditya Burkule. All rights reserved.
//

#import "iRTLoginViewController.h"
#import "iRTTicketListViewController.h"
#import "RequestTracker.h"

@interface iRTLoginViewController ()

@end

@implementation iRTLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginPressed
{
    iRTTicketListViewController* viewController = [[iRTTicketListViewController alloc] init];
    

    RequestTracker* requestTracker = [[RequestTracker alloc] initWithUser:userField.text
                                                                  andPass:passField.text
                                                                  andUrl:uriField.text];
    viewController.requestTracker = requestTracker;
    [[self navigationController] pushViewController:viewController animated:true];
}

- (IBAction)fastLoginPressed
{
    iRTTicketListViewController* viewController = [[iRTTicketListViewController alloc] init];
    [[self navigationController] pushViewController:viewController animated:true];
}

//Close keyboard after hitting return
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
