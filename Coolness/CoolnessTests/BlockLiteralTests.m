#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

void sayHello(void)
{
    printf("Hello!\n");
}

void sayBye(void)
{
    printf("Bye bye!\n");
}

void tellTheWeather(void (*messageFunction)(void))
{
    printf("The weather is nice.\n");
    messageFunction();
}


@interface CoolnessTests : XCTestCase @end

@implementation CoolnessTests

- (void)setUp {
    [super setUp];
    putchar('\n');
}
- (void)tearDown {
    putchar('\n');
    [super tearDown];
}

- (void)showWeatherWithBlock:(void (^)(void))block
{
    NSLog(@"The weather is sunny");
    block();
}

- (void)testBlockLiteralAsArgument
{
    NSString * __block name = @"Fred";
    
    void (^myBlockPtr)(void);
    
    myBlockPtr = ^{
        NSLog(@"Hello from my block, %@!", name);
        name = @"Bob";
    };
    
    [self showWeatherWithBlock:myBlockPtr];
    
    NSLog(@"name is now %@", name);
}

- (void)testBlockLiteral
{
    void (^myBlockPtr)(void);
    
    NSString *name = @"Fred";
    
    myBlockPtr = ^{
        NSLog(@"Hello from my block, %@!", name);
    };
    
    myBlockPtr();
}

- (void)testFunctionPointerAsArgument
{
    tellTheWeather(sayBye);
    tellTheWeather(sayHello);
}

- (void)testFunctionPointers
{
    void (*myFunctionPtr)(void);
    
    myFunctionPtr = sayHello;
    myFunctionPtr();
    
    myFunctionPtr = sayBye;
    myFunctionPtr();
}

@end
