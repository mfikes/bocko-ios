#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, NSFileManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)viewReady:(id)view;

@end

