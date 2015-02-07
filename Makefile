ARCHS = armv7 arm64
include theos/makefiles/common.mk

ADDITIONAL_CFLAGS = -Os
SDKVERSION = 8.1
INCLUDE_SDKVERSION = 8.1
TARGET_IPHONEOS_DEPLOYMENT_VERSION = 7.0
TARGET_CC = xcrun -sdk iphoneos clang
TARGET_CXX = xcrun -sdk iphoneos clang++
TARGET_LD = xcrun -sdk iphoneos clang++

TWEAK_NAME = RevealInjected
RevealInjected_FILES = Tweak.xm
RevealInjected_FRAMEWORKS = UIKit

BUNDLE_NAME = RevealInjectedBundle
RevealInjectedBundle_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries
include $(THEOS)/makefiles/bundle.mk

include $(THEOS_MAKE_PATH)/tweak.mk


after-install::
	install.exec "killall -9 SpringBoard"
