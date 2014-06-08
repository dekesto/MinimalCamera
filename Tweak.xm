/*

I know this probably isn't the best way to go about this, but it works.

- Dekesto

*/

#import <UIKit/UIKit.h>

@interface CAMShutterButton : UIButton
@end

@interface CAMTopBar : UIView
@end

@interface CAMBottomBar : UIView
@end

@interface PLCameraView : UIView

- (CAMShutterButton *)_shutterButton;
- (CAMTopBar *)_topBar;
- (CAMBottomBar *)_bottomBar;

@end

%hook PLCameraView

- (void)layoutSubviews{

	%orig;
	UIView *_previewContainerView = MSHookIvar<UIView *>(self, "_previewContainerView");
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleUI:)];
    UITapGestureRecognizer *snapButton = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(snapButton:)];
    snapButton.numberOfTapsRequired = 2;
    tapGesture.numberOfTapsRequired = 1;
 	tapGesture.numberOfTouchesRequired = 2;
    [_previewContainerView addGestureRecognizer:tapGesture];
    [_previewContainerView addGestureRecognizer:snapButton];
    [tapGesture release];
    [snapButton release];

}

- (BOOL)_previewShouldFillScreenForCameraMode:(int)mode { //Makes 4 inch screens have full screen or black bars for ratio.

	static NSString *settingsPath = @"/var/mobile/Library/Preferences/com.dekesto.minimalcamera.plist";
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];
	BOOL keepRatio = ![[prefs allKeys] containsObject:@"keepRatio"] || [prefs[@"keepRatio"] boolValue];

	if (!keepRatio) {

		mode = 0;
		return YES;
		%orig;

	}

	return %orig;

}

%new

- (void)toggleUI:(UITapGestureRecognizer *)sender {

	static NSString *settingsPath = @"/var/mobile/Library/Preferences/com.dekesto.minimalcamera.plist";
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];
	BOOL isEnabled = ![[prefs allKeys] containsObject:@"isEnabled"] || [prefs[@"isEnabled"] boolValue];

	if(isEnabled) {

		if ([self _topBar].hidden == NO) {

			[[self _topBar] setHidden:YES];
	 		[[self _bottomBar] setHidden:YES];

		} else if ([self _topBar].hidden == YES){

	 		[[self _topBar] setHidden:NO];
	 		[[self _bottomBar] setHidden:NO];

		}

	}
	
}
%new
- (void)snapButton:(UITapGestureRecognizer *)sender {

	static NSString *settingsPath = @"/var/mobile/Library/Preferences/com.dekesto.minimalcamera.plist";
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];
	BOOL isEnabled = ![[prefs allKeys] containsObject:@"isEnabled"] || [prefs[@"isEnabled"] boolValue];

	if(isEnabled) {

		if ([self _bottomBar].hidden == YES) {

			[[self _shutterButton] sendActionsForControlEvents:UIControlEventTouchUpInside];

		}

	}

}
%end