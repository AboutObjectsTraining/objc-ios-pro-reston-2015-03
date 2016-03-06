#import "RELReadingListController.h"
#import "RELViewBookController.h"
#import "RELAddBookController.h"
#import "RELDataSource.h"

//#import "Book.h"
//#import "Author.h"

@interface UIStoryboardSegue (RELAdditions)
- (id)targetViewController;
@end

@implementation UIStoryboardSegue (RELAdditions)

- (id)targetViewController
{
    UIViewController *controller = self.destinationViewController;
    return ([controller isKindOfClass:[UINavigationController class]] ?
            controller.childViewControllers.firstObject : controller);
}

@end


@interface RELReadingListController ()
@property (strong, nonatomic) IBOutlet RELDataSource *dataSource;
@end


@implementation RELReadingListController

- (void)save
{
    [self.dataSource save];
    [self.tableView reloadData];
}

#pragma mark - Unwind Segues

- (IBAction)doneEditingBook:(UIStoryboardSegue *)segue
{
    [self save];
}

- (IBAction)doneAddingBook:(UIStoryboardSegue *)segue
{
    [self save];
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
        RELViewBookController *controller = segue.targetViewController;
        controller.book = self.dataSource.selectedBook;
    }
    else if ([segue.identifier isEqualToString:@"AddBook"])
    {
        RELAddBookController *controller = segue.targetViewController;
        controller.completion = ^(Book *newBook) {
            [self.dataSource insertBook:newBook atIndex:0];
        };
    }
}

@end

