FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"


DESCRIPTION = "Hello, IT?"
HOMEPAGE = "schmid-elektronik.ch"
LICENSE = "GPL-3.0"
SECTION = "base"
DEPENDS = ""
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-3.0;md5=c79ff39f19dfec6d293b95dea7b07891"

SRC_URI = " \
    file://voltcan \
"

inherit update-rc.d
inherit obc_common

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install_append () {
    install -d ${D}${sysconfdir}/init.d

    install -m 0755 ${WORKDIR}/voltcan ${D}${sysconfdir}/init.d
    # NOTE, that Volt- and JmCanService are the same binary
    install -m 0755 ${WORKDIR}/JmCanService ${D}/${OBC_PATH_BIN}/VoltCanService
}

PACKAGE_ARCH = "${MACHINE_ARCH}"

FILES_${PN} += "${sysconfdir}"

INITSCRIPT_NAME = "voltcan"
INITSCRIPT_PARAMS = "start 21 2 3 4 5 . stop 80 0 6 1 ."
