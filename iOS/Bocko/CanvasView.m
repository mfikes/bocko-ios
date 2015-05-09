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
    CGFloat pixelWidth = rect.size.width/40;
    CGFloat pixelHeight = rect.size.height/40;
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (int x = 0; x<40; x++) {
        for (int y = 0; y<40; y++) {
            CGRect rectangle = CGRectMake(x*pixelWidth, y*pixelHeight, pixelWidth+1, pixelHeight+1);
            CGContextSetRGBFillColor(context, pixR[x][y]/255.0, pixG[x][y]/255.0, pixB[x][y]/255.0, 1.0);
            CGContextSetRGBStrokeColor(context, pixR[x][y]/255.0, pixG[x][y]/255.0, pixB[x][y]/255.0, 1.0);
            CGContextFillRect(context, rectangle);
        }
    }
}

@end
