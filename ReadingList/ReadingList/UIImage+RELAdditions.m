#import "UIImage+RELAdditions.h"

@implementation UIImage (RELAdditions)

+ (UIImage *)rel_imageNamed:(NSString *)name
{
    UIImage *image = [self imageNamed:name];
    
    return image != nil ? image : [self imageNamed:@"DefaultImage"];
}

@end
