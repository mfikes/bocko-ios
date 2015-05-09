#import "CanvasView.h"

@interface CanvasView ()

@property CGFloat pixelWidth;
@property CGFloat pixelHeight;
@property CGContextRef drawingContext;

@end

@implementation CanvasView

- (id) initWithCoder: (NSCoder*) coder {
    if (self = [super initWithCoder: coder]) {
        self.backgroundColor = [UIColor clearColor];
        CGSize size = self.frame.size;
        self.drawingContext = [self createDrawingContext: size];
        self.pixelWidth = size.width/40;
        self.pixelHeight = size.height/40;
    }
    
    return self;
}

- (void)plotX:(int)x Y:(int)y red:(int)r green:(int)g blue:(int)b
{
    CGRect rectangle = CGRectMake(x*self.pixelWidth, y*self.pixelHeight, self.pixelWidth+1, self.pixelHeight+1);
    CGContextSetRGBFillColor(self.drawingContext, r/255.0, g/255.0, b/255.0, 1.0);
    CGContextSetRGBStrokeColor(self.drawingContext, r/255.0, g/255.0, b/255.0, 1.0);
    CGContextFillRect(self.drawingContext, rectangle);
}

- (CGContextRef) createDrawingContext: (CGSize) size  {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, size.width*4, colorSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    
    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    return context;
}

- (void)drawRect:(CGRect) rect {
    UIGraphicsPushContext(self.drawingContext);
    CGImageRef cgImage = CGBitmapContextCreateImage(self.drawingContext);
    UIImage *uiImage = [[UIImage alloc] initWithCGImage:cgImage];
    UIGraphicsPopContext();
    CGImageRelease(cgImage);
    [uiImage drawInRect: rect];
}

@end
