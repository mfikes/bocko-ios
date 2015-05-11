#import "CanvasView.h"

static int rpix[40][40];
static int gpix[40][40];
static int bpix[40][40];

@implementation CanvasView

- (void)plotX:(int)x Y:(int)y red:(int)r green:(int)g blue:(int)b
{
    CGSize size = self.frame.size;
    int pixelWidth = (int)size.width/40.0;
    int pixelHeight = (int)size.height/40.0;
    int xOffset = (int)((size.width - 40*pixelWidth)/2);
    int yOffset = (int)((size.height - 40*pixelHeight)/2);
    
    CGRect rectangle = CGRectMake(xOffset + x*pixelWidth,
                                  yOffset + y*pixelHeight,
                                  pixelWidth,
                                  pixelHeight);
    
    rpix[x][y] = r;
    gpix[x][y] = g;
    bpix[x][y] = b;
    
    [self setNeedsDisplayInRect:rectangle];
}

- (void)drawRect:(CGRect) rect {
    
    CGSize size = self.frame.size;
    int pixelWidth = (int)size.width/40.0;
    int pixelHeight = (int)size.height/40.0;
    int xOffset = (int)((size.width - 40*pixelWidth)/2);
    int yOffset = (int)((size.height - 40*pixelHeight)/2);
    
    int x0 = ((int)(rect.origin.x)-xOffset)/pixelWidth;
    int y0 = ((int)(rect.origin.y)-yOffset)/pixelHeight;
    

    int xT = x0 + rect.size.width/pixelWidth;
    int yT = y0 + rect.size.height/pixelHeight;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int x=x0; x<xT; x++) {
        for (int y=y0; y<yT; y++) {
            CGRect pixRect = CGRectMake(xOffset + x*pixelWidth,
                                        yOffset + y*pixelHeight,
                                        pixelWidth,
                                        pixelHeight);
            
            int r = rpix[x][y];
            int g = gpix[x][y];
            int b = bpix[x][y];
            
            CGContextSetRGBFillColor(context, r/255.0, g/255.0, b/255.0, 1.0);
            CGContextSetRGBStrokeColor(context, r/255.0, g/255.0, b/255.0, 1.0);
            CGContextFillRect(context, pixRect);
        }
    }
    
    
}

@end
