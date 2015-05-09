#import "ViewController.h"

#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)plotX:(int)x Y:(int)y red:(int)r green:(int)g blue:(int)b
{
    NSLog(@"%d %d %d %d %d", x, y, r, g, b);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self handleViewDidLoad];
}

- (void)handleViewDidLoad
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate viewReady:self];
}

@end
