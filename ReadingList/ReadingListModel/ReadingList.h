#import <Foundation/Foundation.h>
#import "ModelObject.h"

@interface ReadingList : ModelObject

+ (instancetype)readingListWithTitle:(NSString *)title books:(NSArray *)books;
- (id)initWithTitle:(NSString *)title books:(NSArray *)books;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *books;

@end
