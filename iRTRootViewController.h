//
//  iRTRootViewController.h
//  iRequestTracker
//
//  Created by Aditya Burkule on 12/2/12.
//  Copyright (c) 2012 Aditya Burkule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iRTTicketViewController.h"

@interface iRTRootViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tableView;
    NSMutableDictionary *ticketDictionary;
    iRTTicketViewController *ticketViewController_;
}

- (iRTTicketViewController*)ticketViewController;

@end
