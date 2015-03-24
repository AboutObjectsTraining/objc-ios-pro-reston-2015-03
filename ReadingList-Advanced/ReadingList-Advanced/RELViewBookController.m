#import "RELViewBookController.h"
#import "RELEditBookController.h"
#import "UIImage+RELAdditions.h"
#import "Book.h"
#import "Author.h"

@interface RELViewBookController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *authorImageView;

@end


@implementation RELViewBookController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.authorImageView.layer.cornerRadius = 8.0;
    self.authorImageView.layer.masksToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.titleLabel.text = self.book.title;
    self.yearLabel.text = self.book.year;
    self.firstNameLabel.text = self.book.author.firstName;
    self.lastNameLabel.text = self.book.author.lastName;
    
    self.authorImageView.image = [UIImage rel_imageNamed:self.book.author.lastName];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *navController = segue.destinationViewController;
    RELEditBookController *editController = navController.childViewControllers.firstObject;
    editController.book = self.book;
}

@end
