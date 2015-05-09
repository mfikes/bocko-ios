#import <UIKit/UIKit.h>

#import <JavaScriptCore/JavaScriptCore.h>

@protocol CanvasViewController <JSExport>

- (void)plotX:(int)x Y:(int)y red:(int)r green:(int)g blue:(int)b;

@end

@interface ViewController : UIViewController<CanvasViewController>

@end

