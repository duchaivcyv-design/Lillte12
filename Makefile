FINALPACKAGE = 1

THEOS_PACKAGE_SCHEME ?= rootless

export TARGET = iphone:clang:13.5:14.0
export ADDITIONAL_CFLAGS = -DTHEOS_LEAN_AND_MEAN -fobjc-arc

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Little12SpringBoard Little12UIKit
Little12SpringBoard_FILES = TweakSpring.xm
Little12UIKit_FILES = TweakUI.xm
Little12UIKit_WEAK_LIBRARIES = $(THEOS_LIBRARY_PATH)/libhooker.dylib

ARCHS = arm64 arm64e

ifeq ($(THEOS_PACKAGE_SCHEME),roothide)
Little12SpringBoard_LIBRARIES += roothide
Little12UIKit_LIBRARIES += roothide
endif

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += little12prefs
include $(THEOS_MAKE_PATH)/aggregate.mk