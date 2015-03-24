#import "RELFileUtilities.h"

NSString *RELPathForDocument(NSString *name, NSString *extension)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[paths.firstObject stringByAppendingPathComponent:name] stringByAppendingPathExtension:extension];
}
