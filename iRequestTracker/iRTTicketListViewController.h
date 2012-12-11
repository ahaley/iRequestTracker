//
//  iRTTicketListViewController.h
//  iRequestTracker
//
//  Created by Aditya Burkule on 12/2/12.
//  Copyright (c) 2012 Aditya Burkule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iRTTicketViewController.h"
#import "RequestTracker.h"

@interface iRTTicketListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tableView;
    NSMutableDictionary *ticketDictionary;
    iRTTicketViewController *ticketViewController_;
    RequestTracker* requestTracker_;
}

- (iRTTicketViewController*)ticketViewController;

@property (nonatomic, retain) RequestTracker* requestTracker;

@end
