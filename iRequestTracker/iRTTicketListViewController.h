//
//  iRTTicketListViewController.h
//  iRequestTracker
//
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
