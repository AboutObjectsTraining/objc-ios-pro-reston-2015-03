#import "RELAddBookController.h"
#import "Book.h"
#import "Author.h"

@interface RELAddBookController ()

@property (strong, nonatomic) Book *book;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *yearField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;

@end


@implementation RELAddBookController

- (void)createBook
{
    self.book = [[Book alloc] init];
    self.book.title = self.titleField.text;
    self.book.year = self.yearField.text;
    
    self.book.author = [[Author alloc] init];
    self.book.author.firstName = self.firstNameField.text;
    self.book.author.lastName = self.lastNameField.text;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier hasPrefix:@"Done"])
    {
        [self createBook];
    }
}

@end
