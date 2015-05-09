#import "CanvasView.h"

static int pixR[40][40];
static int pixG[40][40];
static int pixB[40][40];

@implementation CanvasView

- (void)plotX:(int)x Y:(int)y red:(int)r green:(int)g blue:(int)b
{
    pixR[x][y] = r;
    pixG[x][y] = g;
    pixB[x][y] = b;
}

-(void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (int x = 0; x<40; x++) {
        for (int y = 0; y<40; y++) {
            CGRect rectangle = CGRectMake(x*16, y*8, 16, 8);
            CGContextSetRGBFillColor(context, pixR[x][y]/255.0, pixG[x][y]/255.0, pixB[x][y]/255.0, 1.0);
            CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
            CGContextFillRect(context, rectangle);
        }
    }
}

@end
