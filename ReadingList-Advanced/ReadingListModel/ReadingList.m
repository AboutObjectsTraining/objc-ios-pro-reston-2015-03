#import "ReadingList.h"
#import "Book.h"

@implementation ReadingList

- (id)initWithTitle:(NSString *)title books:(NSArray *)books
{
    if (!(self = [super initWithDictionary:@{@"title" : title,
                                             @"books" : books}])) return nil;
    return self;
}

+ (instancetype)readingListWithTitle:(NSString *)title books:(NSArray *)books
{
    return [[self alloc] initWithTitle:title books:books];
}

+ (NSArray *)keys
{
    static NSArray *_keys;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _keys = @[ @"title", @"books" ];
    });
    return _keys;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableValues = [[super dictionaryWithValuesForKeys:[[self class] keys]] mutableCopy];
    
    NSArray *books = [mutableValues objectForKey:@"books"];
    NSMutableArray *bookDicts = [NSMutableArray arrayWithCapacity:[books count]];
    
    for (Book *currBook in books)
    {
        [bookDicts addObject:[currBook dictionaryRepresentation]];
    }
    
    [mutableValues setObject:bookDicts forKey:@"books"];
    
    return mutableValues;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"books"])
    {
        NSArray *bookDicts = (NSArray *) value;
        
        if ([bookDicts.firstObject isKindOfClass:[NSDictionary class]])
        {
            NSMutableArray *bookObjs = [NSMutableArray arrayWithCapacity:bookDicts.count];
            
            for (NSDictionary *currDict in bookDicts)
            {
                [bookObjs addObject:[Book modelObjectWithDictionary:currDict]];
            }
            
            value = bookObjs;
        }
    }
    
    [super setValue:value forKey:key];
}

- (NSString *)description
{
    NSString *desc = [NSString stringWithFormat:
                      @"\nTitle: %@"
                      @"\nBooks: %@",
                      [self title],
                      [self books]];
    return desc;
}

@end
