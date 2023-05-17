SUMMARY = "A console-only image for Ka-Ro electronics TX modules"
IMAGE_BASENAME = "obc-image-bb"

require obc-image.inc

IMAGE_LINGUAS = "en-us"

IMAGE_FEATURES_append = " ssh-server-openssh package-management"

IMAGE_INSTALL_append = " \
    gasflow \
    jm2 \
    jmcan \
    lfm \
    sb \
    supply \
    voltcan \
    utilities \
"

python extend_recipe_sysroot_append() {
    if d.getVar('DISTRO') != 'obc-base':
        raise_sanity_error("cannot build 'obc-image-bb' with DISTRO '%s'" % d.getVar('DISTRO'), d)
}

#ROOTFS_PARTITION_SIZE = "262144"
ROOTFS_PARTITION_SIZE = "524288"

# for some reason PACKAGE_CLASSES needs to be defined in localconf, why?
# it also cannot generate the sdk, maybe https://github.com/STMicroelectronics/meta-st-stm32mp/commit/826ca201ff6ffd030b92971d904a93a36fd2d068
# PACKAGE_CLASSES = "package_deb"
