export ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

TWEAK_NAME = MinimalCamera
MinimalCamera_FILES = Tweak.xm
MinimalCamera_FRAMEWORKS = UIKit 
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += minimalcamera
include $(THEOS_MAKE_PATH)/aggregate.mk
