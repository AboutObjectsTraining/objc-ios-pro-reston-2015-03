#import "UIImage+RELAdditions.h"
#import "RELFileUtilities.h"
#import "RELReadingListController.h"
#import "RELViewBookController.h"
#import "RELAddBookController.h"
#import "ReadingList.h"
#import "Book.h"
#import "Author.h"

@interface RELReadingListController ()
@property (strong, nonatomic) NSMutableArray *books;
@property (readonly, nonatomic) NSString *dataStoreName;
@end


@implementation RELReadingListController

- (NSString *)dataStoreName
{
    return @"BooksAndAuthors";
}


#pragma mark - Unwind Segues

- (IBAction)doneEditingBook:(UIStoryboardSegue *)segue
{
    // Save changes
    [self saveReadingList];

    // Refresh visible table view cells
    [self.tableView reloadData];
}

- (IBAction)doneAddingBook:(UIStoryboardSegue *)segue
{
    RELAddBookController *controller = segue.sourceViewController;
    [self.books insertObject:controller.book atIndex:0];
    [self saveReadingList];
    
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
}

- (IBAction)cancelEditingBook:(UIStoryboardSegue *)segue {  }
- (IBAction)cancelAddingBook:(UIStoryboardSegue *)segue  {  }


#pragma mark - Persistence

- (void)loadReadingList
{
    // Try to load from the Documents directory in the app sandbox.
    NSString *path = RELPathForDocument(self.dataStoreName, @"plist");
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (dict == nil) {
        // Fall back to loading from the app bundle.
        path = [[NSBundle mainBundle] pathForResource:self.dataStoreName ofType:@"plist"];
        dict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    
    ReadingList *readingList = [ReadingList modelObjectWithDictionary:dict];
    self.books = [readingList.books mutableCopy];
    self.title = readingList.title;
}

- (void)saveReadingList
{
    ReadingList *newReadingList = [[ReadingList alloc] init];
    newReadingList.title = self.title;
    newReadingList.books = self.books;
    
    NSDictionary *dict = newReadingList.dictionaryRepresentation;
    NSString *path = RELPathForDocument(self.dataStoreName, @"plist");
    [dict writeToFile:path atomically:YES];
}


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadReadingList];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ViewBook"])
    {
        RELViewBookController *controller = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        controller.book = self.books[indexPath.row];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookSummary"];
    
    Book *book = self.books[indexPath.row];
    
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@  %@", book.year, book.author.fullName];
    cell.imageView.image = [UIImage rel_imageNamed:book.author.lastName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.books removeObjectAtIndex:indexPath.row];
        [self saveReadingList];
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
