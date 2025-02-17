SUMMARY = "A console-only image for Ka-Ro electronics TX modules"
IMAGE_BASENAME = "obc-image-fin"

require obc-image.inc

IMAGE_LINGUAS = "en-us"

DISTRO_FEATURES_append = " bluetooth bluez5"

IMAGE_FEATURES_append = " ssh-server-openssh package-management"

IMAGE_INSTALL_append = " \
    dout \
    gps \
    mobile \
    obcagent \
    health \
    config \
    utilities \
    kernel-module-lwb5p-backports-laird \
    sterling-supplicant-lwb \
"

IMAGE_INSTALL_append_qsmp-1530-fin = " \
    lwb5plus-usb-sa-firmware \
"

IMAGE_INSTALL_append_qsmp-1570-fin = " \
    lwb5plus-usb-sa-firmware \
"

# wifi regulatory domain, use on of US, CA(canada), ETSI(europe), JP, AU, NZ
LWB_REGDOMAIN = "ETSI"

python extend_recipe_sysroot_append() {
    if d.getVar('DISTRO') != 'obc-base':
        raise_sanity_error("cannot build 'obc-image-fin' with DISTRO '%s'" % d.getVar('DISTRO'), d)
}

#ROOTFS_PARTITION_SIZE = "262144"
#ROOTFS_PARTITION_SIZE = "524288"
#ROOTFS_PARTITION_SIZE = "1048576"
ROOTFS_PARTITION_SIZE = "2097152"

# for some reason PACKAGE_CLASSES needs to be defined in localconf, why?
# it also cannot generate the sdk, maybe https://github.com/STMicroelectronics/meta-st-stm32mp/commit/826ca201ff6ffd030b92971d904a93a36fd2d068
# PACKAGE_CLASSES = "package_deb"
