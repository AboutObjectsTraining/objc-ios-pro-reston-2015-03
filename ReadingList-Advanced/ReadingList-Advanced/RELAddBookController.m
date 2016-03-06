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

- (NSDictionary *)bookDictionary
{
    return @{ @"title" : self.titleField.text,
              @"year"  : self.yearField.text,
              @"author": @{ @"firstName": self.firstNameField.text,
                            @"lastName" : self.lastNameField.text }};
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier hasPrefix:@"Done"])
    {
        self.completion([Book modelObjectWithDictionary:self.bookDictionary]);
    }
}

@end
