#import "RELDataSource.h"
#import "RELFileUtilities.h"
#import "UIImage+RELAdditions.h"
#import "ReadingList.h"
#import "Book.h"
#import "Author.h"

@interface RELDataSource()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *books;
@property (strong, nonatomic) NSString *title;
@end

@implementation RELDataSource

- (instancetype)init
{
    if (!(self = [super init])) return nil;

    // Try to load from the Documents directory in the app sandbox.
    NSString *path = RELPathForDocument(self.dataStoreName, @"plist");
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (dict == nil) {
        // Fall back to loading from the app bundle.
        path = [[NSBundle mainBundle] pathForResource:self.dataStoreName ofType:@"plist"];
        dict = [NSDictionary dictionaryWithContentsOfFile:path];
        
        // If we can't initialize the data source, init method must return nil.
        if (dict == nil) {
            return nil;
        }
    }
    
    ReadingList *readingList = [ReadingList modelObjectWithDictionary:dict];
    _books = [readingList.books mutableCopy];
    _title = readingList.title;
    
    return self;
}

- (NSArray *)allBooks
{
    return self.books;
}

- (NSString *)dataStoreName
{
    return @"BooksAndAuthors";
}

- (NSString *)cellIdentifier
{
    return @"BookSummary";
}

- (Book *)selectedBook
{
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    
    return self.books[indexPath.row];
}

- (void)insertBook:(Book *)book atIndex:(NSUInteger)index
{
    [self.books insertObject:book atIndex:index];
}

- (void)save
{
    ReadingList *newReadingList = [[ReadingList alloc] init];
    newReadingList.title = self.title;
    newReadingList.books = self.books;
    
    NSDictionary *dict = newReadingList.dictionaryRepresentation;
    NSString *path = RELPathForDocument(self.dataStoreName, @"plist");
    [dict writeToFile:path atomically:YES];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    
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
        [self save];
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
