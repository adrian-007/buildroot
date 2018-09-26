################################################################################
#
# usb_modeswitch
#
################################################################################

USB_MODESWITCH_VERSION = 2733b14dd8aee5e5965cce01a32c8bf14c360ec8
USB_MODESWITCH_SITE = $(call github,adrian-007,usb_modeswitch,$(USB_MODESWITCH_VERSION))

USB_MODESWITCH_DEPENDENCIES = libusb
USB_MODESWITCH_LICENSE = GPL-2.0+
USB_MODESWITCH_LICENSE_FILES = COPYING
# Package does not build in parallel due to improper make rules
USB_MODESWITCH_MAKE = $(MAKE1)

USB_MODESWITCH_BUILD_TARGETS = static
USB_MODESWITCH_INSTALL_TARGETS = install-static

ifeq ($(BR2_PACKAGE_TCL)$(BR2_PACKAGE_TCL_SHLIB_ONLY),y)
USB_MODESWITCH_CONF_OPTS += -DCMAKE_USE_LOCAL_TCL_INTERPRETER=ON
USB_MODESWITCH_DEPENDENCIES += tcl
USB_MODESWITCH_BUILD_TARGETS = script
USB_MODESWITCH_INSTALL_TARGETS = install-script
else
USB_MODESWITCH_DEPENDENCIES += jimtcl
endif

$(eval $(cmake-package))
