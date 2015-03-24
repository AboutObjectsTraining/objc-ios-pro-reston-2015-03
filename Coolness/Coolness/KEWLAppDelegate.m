#import "KEWLAppDelegate.h"
#import "KEWLCoolController.h"

@implementation KEWLAppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[KEWLCoolController alloc] initWithNibName:@"CoolStuff" bundle:nil];
    self.window.backgroundColor = [UIColor lightGrayColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
