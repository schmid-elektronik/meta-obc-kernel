FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"


DESCRIPTION = "OBC utlilities"
HOMEPAGE = "schmid-elektronik.ch"
LICENSE = "GPL-3.0"
SECTION = "base"
DEPENDS = "dhcpcd"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-3.0;md5=c79ff39f19dfec6d293b95dea7b07891"

SRC_URI = " \
    file://synclogs.sh \
"

SRC_URI_append_qsmp-1570-fin  = " file://synclogs.fin "
SRC_URI_append_qsmp-1570-bb  = " file://synclogs.bb "

inherit update-rc.d
inherit obc_common

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install_append_qsmp-1570-fin () {
    install -d ${D}${sysconfdir}/init.d

    install -m 0755 ${WORKDIR}/synclogs.fin ${D}${sysconfdir}/init.d/synclogs
    install -m 0755 ${WORKDIR}/synclogs.sh ${D}/${OBC_PATH_BIN}
}

do_install_append_qsmp-1570-bb () {
    install -d ${D}${sysconfdir}/init.d

    install -m 0755 ${WORKDIR}/synclogs.bb ${D}${sysconfdir}/init.d/synclogs
    install -m 0755 ${WORKDIR}/synclogs.sh ${D}/${OBC_PATH_BIN}
}

PACKAGE_ARCH = "${MACHINE_ARCH}"

FILES_${PN} += "${sysconfdir}"

INITSCRIPT_NAME = "synclogs"
INITSCRIPT_PARAMS = "start 22 2 3 4 5 ."
