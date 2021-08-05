SUMMARY = "A console-only image for Ka-Ro electronics TX modules"
IMAGE_BASENAME = "obc-image-base"

require obc-image.inc
require obc-minimal.inc

DISTRO_FEATURES_append = " busybox-crond"

IMAGE_LINGUAS_append = " de-de"

IMAGE_FEATURES_append = " splash ssh-server-openssh"
IMAGE_INSTALL_append_karo-base = " udev"
PACKAGE_EXCLUDE = "python3-core"

python extend_recipe_sysroot_append() {
    if d.getVar('DISTRO') != 'obc-base':
        raise_sanity_error("cannot build 'obc-image-base' with DISTRO '%s'" % d.getVar('DISTRO'), d)
}
