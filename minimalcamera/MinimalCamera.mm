#import <Preferences/Preferences.h>

@interface MinimalCameraListController: PSListController {


}


@end

@implementation MinimalCameraListController

- (void)viewDidLoad {

	[super viewDidLoad];

	[[UISwitch appearanceWhenContainedIn:self.class, nil] setOnTintColor:[UIColor colorWithRed: 52.0/255.0 green: 152.0/255.0 blue:255.0/255.0 alpha: 1.0]];

}

- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"MinimalCamera" target:self] retain];
	}
	return _specifiers;
}

-(void)twitter {

	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://mobile.twitter.com/Dekesto"]];

}

@end

@interface GuideListController: PSListController {
}
@end

@implementation GuideListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Guide" target:self] retain];
	}

	return _specifiers;

}

@end



// vim:ft=objc
