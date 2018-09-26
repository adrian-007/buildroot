################################################################################
#
# camera_streamer
#
################################################################################

CAMERA_STREAMER_VERSION = 1aa9535577345a292d9c148d9a8063f35736a7f8
CAMERA_STREAMER_SITE = $(call github,adrian-007,camera_streamer,$(CAMERA_STREAMER_VERSION))

CAMERA_STREAMER_DEPENDENCIES = libcurl ffmpeg boost

ifeq ($(BR2_PACKAGE_CAMERA_STREAMER_SERVICE),y)


define CAMERA_STREAMER_INSTALL_INIT_SYSV
    $(INSTALL) -D -m 755 package/camera_streamer/S80camera $(TARGET_DIR)/etc/init.d/S80camera
endef


endif

$(eval $(cmake-package))
