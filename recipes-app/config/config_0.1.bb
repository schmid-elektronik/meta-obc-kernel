FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"


DESCRIPTION = "Hello, IT?"
HOMEPAGE = "schmid-elektronik.ch"
LICENSE = "GPL-3.0"
SECTION = "base"
DEPENDS = "python3-core python3-requests"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-3.0;md5=c79ff39f19dfec6d293b95dea7b07891"

SRC_URI = " \
    file://cmdargs.py  \
    file://conffile.py  \
    file://config  \
    file://error_description.py \
    file://main.py  \
    file://semapi.py \
"

inherit update-rc.d
inherit obc_common

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install () {
    install -d ${D}${sysconfdir}/init.d
    install -d ${D}${OBC_PATH_BIN}/configService

    install -m 0755 ${WORKDIR}/config ${D}${sysconfdir}/init.d

    install -m 0644 ${WORKDIR}/cmdargs.py ${D}${OBC_PATH_BIN}/configService
    install -m 0644 ${WORKDIR}/conffile.py ${D}${OBC_PATH_BIN}/configService
    install -m 0644 ${WORKDIR}/error_description.py ${D}${OBC_PATH_BIN}/configService
    install -m 0644 ${WORKDIR}/main.py ${D}${OBC_PATH_BIN}/configService
    install -m 0644 ${WORKDIR}/semapi.py ${D}${OBC_PATH_BIN}/configService
}

PACKAGE_ARCH = "${MACHINE_ARCH}"

FILES_${PN} += "${sysconfdir}"

INITSCRIPT_NAME = "config"
INITSCRIPT_PARAMS = "start 21 2 3 4 5 ."
