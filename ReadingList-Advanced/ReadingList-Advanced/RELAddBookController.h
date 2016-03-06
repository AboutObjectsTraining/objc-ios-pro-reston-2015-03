#import <UIKit/UIKit.h>

@class Book;

@interface RELAddBookController : UITableViewController

@property (readonly, nonatomic) Book *book;

@property (strong, nonatomic) void (^completion)(Book *newBook);

@end
