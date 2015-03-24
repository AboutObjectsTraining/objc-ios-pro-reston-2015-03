#import "KEWLCoolView.h"

const CGFloat KEWLTextPadding = 7.5;

@implementation KEWLCoolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self == nil) return nil;
    
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.layer.cornerRadius = 8.0;
    self.layer.masksToBounds = YES;
    
    return self;
}

//
// TODO: UIColor example, etc.
//
UIFont *KEWLSuperGlobalDefaultFontForEverything(void)
{
    return [UIFont boldSystemFontOfSize:18.0];
}

+ (UIFont *)defaultFont
{
    return KEWLSuperGlobalDefaultFontForEverything();
}

- (CGSize)sizeThatFits:(CGSize)size
{
    UIFont *font = [self.class defaultFont];
    CGSize newSize = [self.text sizeWithAttributes:@{ NSFontAttributeName: font }];
    newSize.width += 2 * KEWLTextPadding;
    newSize.height += 2 * KEWLTextPadding;
    
    return newSize;
}

- (void)drawRect:(CGRect)rect
{
    CGPoint location = { KEWLTextPadding, KEWLTextPadding };
    
    UIFont *font = [self.class defaultFont];
    
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSForegroundColorAttributeName: [UIColor whiteColor] };
    
    [self.text drawAtPoint:location withAttributes:attributes];
}


- (void)animateFinalMoveWithSize:(CGSize)size
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    
    self.transform = CGAffineTransformIdentity;
    self.frame = CGRectOffset(self.frame, -size.width, -size.height);
    
    [UIView commitAnimations];
}

- (void)animateMoveWithSize:(CGSize)size
{
    [UIView animateWithDuration:1.0
                     animations:^{
                         [UIView setAnimationRepeatCount:3.5];
                         [UIView setAnimationRepeatAutoreverses:YES];
                         self.frame = CGRectOffset(self.frame, size.width, size.height);
                         self.transform = CGAffineTransformMakeRotation(M_PI_2);
                     }
                     completion:^(BOOL finished) {
                         [self animateFinalMoveWithSize:size];
                     }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.alpha = 0.5;
    
    [self.superview bringSubviewToFront:self];

    if ([touches.anyObject tapCount] == 2)
    {
        [self animateMoveWithSize:CGSizeMake(120.0, 240.0)];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint currLocation = [touch locationInView:self.superview];
    CGPoint prevLocation = [touch previousLocationInView:self.superview];
    
    CGPoint newLocation = self.center;
    
    newLocation.x += currLocation.x - prevLocation.x;
    newLocation.y += currLocation.y - prevLocation.y;
    
    self.center = newLocation;
}

- (void)endTouches
{
    self.alpha = 1.0;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endTouches];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endTouches];
}

@end
