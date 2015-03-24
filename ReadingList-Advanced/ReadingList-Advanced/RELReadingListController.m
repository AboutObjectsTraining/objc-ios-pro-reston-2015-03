#import "RELReadingListController.h"
#import "RELViewBookController.h"
#import "RELAddBookController.h"
#import "RELDataSource.h"

//#import "Book.h"
//#import "Author.h"

@interface RELReadingListController ()
@property (strong, nonatomic) IBOutlet RELDataSource *dataSource;
@end


@implementation RELReadingListController


#pragma mark - Unwind Segues

- (IBAction)doneEditingBook:(UIStoryboardSegue *)segue
{
    // Save changes
    [self.dataSource save];

    // Refresh visible table view cells
    [self.tableView reloadData];
}

- (IBAction)doneAddingBook:(UIStoryboardSegue *)segue
{
    RELAddBookController *controller = segue.sourceViewController;
    [self.dataSource insertBook:controller.book atIndex:0];
    [self.dataSource save];
    
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
}

- (IBAction)cancelEditingBook:(UIStoryboardSegue *)segue {  }
- (IBAction)cancelAddingBook:(UIStoryboardSegue *)segue  {  }


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.dataSource.title;
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ViewBook"])
    {
        RELViewBookController *controller = segue.destinationViewController;
        controller.book = self.dataSource.selectedBook;
    }
}

@end
