GO_EASY_ON_ME=1
export ARCHS = armv7 armv7s arm64
include theos/makefiles/common.mk

BUNDLE_NAME = MinimalCamera
MinimalCamera_FILES = MinimalCamera.mm PFHeaderCell.mm
MinimalCamera_INSTALL_PATH = /Library/PreferenceBundles
MinimalCamera_FRAMEWORKS = UIKit
MinimalCamera_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/MinimalCamera.plist$(ECHO_END)
