//
//  iRTRootViewController.h
//  iRequestTracker
//
//  Created by Antonio Haley on 12/2/12.
//  Copyright (c) 2012 Antonio Haley. All rights reserved.
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
