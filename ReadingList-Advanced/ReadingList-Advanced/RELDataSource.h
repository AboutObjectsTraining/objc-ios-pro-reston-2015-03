#import <UIKit/UIKit.h>

@class Book;

@interface RELDataSource : NSObject <UITableViewDataSource>

@property (readonly, nonatomic) NSString *dataStoreName;
@property (readonly, nonatomic) NSString *cellIdentifier;
@property (readonly, nonatomic) NSString *title;
@property (readonly, nonatomic) NSArray *allBooks;

@property (readonly, nonatomic) Book *selectedBook;

- (void)save;
- (void)insertBook:(Book *)book atIndex:(NSUInteger)index;

@end
