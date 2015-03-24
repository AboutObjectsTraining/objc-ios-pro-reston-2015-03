#import "KEWLCoolController.h"
#import "KEWLCoolView.h"

@interface KEWLCoolController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end


@implementation KEWLCoolController

- (void)dealloc
{
    self.textField.delegate = nil;
}


#pragma mark - Actions

- (IBAction)addCoolView:(id)sender
{
    NSLog(@"In %s, text is %@", __func__, self.textField.text);
    
    KEWLCoolView *newCoolView = [[KEWLCoolView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:newCoolView];
    
    newCoolView.text = self.textField.text;
    [newCoolView sizeToFit];
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"The following view got touched: %@", [touches.anyObject view]);
//}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    KEWLCoolView *view1 = [[KEWLCoolView alloc] initWithFrame:CGRectMake(20.0, 40.0, 80.0, 30.0)];
    KEWLCoolView *view2 = [[KEWLCoolView alloc] initWithFrame:CGRectMake(60.0, 100.0, 80.0, 30.0)];
    
    view1.text = @"Here's some text.";
    view2.text = @"Wow, Cool Views rock!";
    
    [view1 sizeToFit];
    [view2 sizeToFit];

    [self.contentView addSubview:view1];
    [self.contentView addSubview:view2];
    
    view1.backgroundColor = [UIColor purpleColor];
    view2.backgroundColor = [UIColor orangeColor];
}

//- (void)loadView
//{
////    UIView *backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    
//    /* NSArray *topLevelObjs = */
//    
//    [[NSBundle mainBundle] loadNibNamed:@"CoolStuff"
//                                  owner:self
//                                options:nil];
//    
////    UIView *backgroundView = topLevelObjs.firstObject;
////    self.view = backgroundView;
//    
////    backgroundView.backgroundColor = [UIColor brownColor];
//}

@end
