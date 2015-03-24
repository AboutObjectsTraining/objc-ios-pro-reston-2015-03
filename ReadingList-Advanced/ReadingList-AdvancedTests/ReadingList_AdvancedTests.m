#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RELDataSource.h"
#import "ReadingList.h"
#import "Book.h"
#import "Author.h"

@interface ReadingListTests : XCTestCase
@property (strong, nonatomic) RELDataSource *dataSource;
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
    self.dataSource = [[RELDataSource alloc] init];
    NSLog(@"%@", self.dataSource.allBooks);
    XCTAssertNotNil(self.dataSource.allBooks);
}

@end
