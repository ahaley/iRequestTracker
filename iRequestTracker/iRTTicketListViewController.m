//
//  iRTTicketListViewController.m
//  iRequestTracker
//

#import "iRTTicketListViewController.h"
#import "AFNetworking.h"
#import "RequestTracker.h"

@implementation iRTTicketListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        ticketDictionary = [NSMutableDictionary dictionaryWithCapacity:200];

    }
    return self;
}

- (RequestTracker*)requestTracker
{
    if (requestTracker_ == nil) {
        requestTracker_ = [[RequestTracker alloc] init];
    }
    return requestTracker_;
}

- (void)setRequestTracker:(RequestTracker *)requestTracker
{
    requestTracker_ = requestTracker;
}

- (iRTTicketViewController*)ticketViewController
{
    if (ticketViewController_ == nil) {
        ticketViewController_ = [[iRTTicketViewController alloc] init];
        [ticketViewController_ setRequestTracker:[self requestTracker]];
    }
    return ticketViewController_;
}


- (void)viewDidLoad
{
    
    UIBarButtonItem *actionBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTicket)];
    self.navigationItem.rightBarButtonItem = actionBtn;
}

- (void)viewDidAppear:(BOOL)animated
{
    [ticketDictionary removeAllObjects];
    [self downloadTickets];
}

- (void)addTicket
{
    iRTTicketViewController *child = [self ticketViewController];
 
    [child setNew];
    
    [self.navigationController pushViewController:child animated:true];
}


- (void)parseTicketList:(NSString*)listString
{
    NSArray* lines = [listString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    for (NSString *line in lines) {
        NSArray* components = [line componentsSeparatedByString:@":"];
        if ([components count] == 2) {
            
            [ticketDictionary setObject:[components objectAtIndex:1]
                                forKey:[components objectAtIndex:0]];
        }
    }
    
    [tableView reloadData];
}

- (void)downloadTickets
{
    RequestTracker* tracker = [self requestTracker];

    [tracker getTicketList:^(AFHTTPRequestOperation *operation, id responseObject) {

        static NSString* credentialsRequiredPreamble = @"RT/4.0.4 401 Credentials required";
        
        if ([operation.responseString hasPrefix:credentialsRequiredPreamble]) {
        
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Login Fail" message:operation.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [message show];
        
        }
        else {
            [self parseTicketList:operation.responseString];
        }
    }];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ticketDictionary count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rtTableViewCell"];
    [[cell textLabel] setText:[[ticketDictionary allValues] objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate Methods
//respond to user selecting cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    iRTTicketViewController *child = [self ticketViewController];
    
    NSString *ticketId = [[ticketDictionary allKeys] objectAtIndex:indexPath.row];
    
    [child loadTicketId:ticketId];
    
    [self.navigationController pushViewController:child animated:true];
}

@end
