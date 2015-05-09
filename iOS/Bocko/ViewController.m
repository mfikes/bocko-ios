#import "ViewController.h"
#import "CanvasView.h"

#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)plotX:(int)x Y:(int)y red:(int)r green:(int)g blue:(int)b
{
    CanvasView* canvasView = (CanvasView*)self.view;
    [canvasView plotX:x Y:y red:r green:g blue:b];
}

- (void)refreshDisplay
{
    [self.view setNeedsDisplay];
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
