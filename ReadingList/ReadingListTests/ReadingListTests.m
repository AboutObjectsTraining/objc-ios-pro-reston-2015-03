#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RELReadingListController.h"
#import "ReadingList.h"
#import "Book.h"
#import "Author.h"

@interface RELReadingListController()
@property (strong, nonatomic) NSMutableArray *books;
- (void)loadReadingList;
@end

@interface ReadingListTests : XCTestCase
@end

@implementation ReadingListTests

- (void)setUp {
    [super setUp];
    putchar('\n');
}
- (void)tearDown {
    putchar('\n');
    [super tearDown];
}

- (void)testCreateDataSource
{
    RELReadingListController *controller = [[RELReadingListController alloc] init];
    [controller loadReadingList];
    NSLog(@"%@", controller.books);
    XCTAssertNotNil(controller.books);
}

@end
