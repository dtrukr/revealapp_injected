#import <dlfcn.h>
#import <UIKit/UIKit.h>
#include <notify.h>
#include <objc/message.h>


__attribute__((visibility("hidden")))
@interface RevealInjected : NSObject {
@private
}
@end

#define kBundlePath @"/Library/MobileSubstrate/DynamicLibraries/RevealInjectedBundle.bundle"

@implementation RevealInjected

+ (instancetype)sharedInstance
{
    static RevealInjected *_sharedFactory;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedFactory = [[self alloc] init];
    });

    return _sharedFactory;
}

- (id)init
{
        if ((self = [super init]))
        {
                     
        }
        return self;
}

-(void)inject {
	
	NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.daapps.revealinjected.plist"];
	id setting = [settings objectForKey:[NSString stringWithFormat:@"RevealInjectedEnabled-%@", [NSBundle mainBundle].bundleIdentifier]];
	if (setting && [setting boolValue]) {

		NSString *revealLibName = @"libReveal";
	    NSString *revealLibExtension = @"dylib";
	    
	    NSBundle *bundle = [[[NSBundle alloc] initWithPath:kBundlePath] autorelease];
	    NSString *dyLibPath = [bundle pathForResource:revealLibName ofType:revealLibExtension];
	
	    void *revealLib = NULL;
	    revealLib = dlopen([dyLibPath cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);
	
	    if (revealLib == NULL) 
	    {
	        char *error = dlerror();
	        NSLog(@"RevealInjected: dlopen error: %s", error);
	    }
		
	} 
	
}

@end


%ctor {

    [[NSNotificationCenter defaultCenter] addObserver:[RevealInjected sharedInstance] selector:@selector(inject) name:UIApplicationDidFinishLaunchingNotification object:nil];

}