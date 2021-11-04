FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"


DESCRIPTION = "Hello, IT?"
HOMEPAGE = "schmid-elektronik.ch"
LICENSE = "GPL-3.0"
SECTION = "base"
DEPENDS = ""
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-3.0;md5=c79ff39f19dfec6d293b95dea7b07891"

SRC_URI = " \
    file://obcagent \
"

inherit update-rc.d

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install () {
    install -d ${D}${sysconfdir}/init.d

    install -m 0755 ${WORKDIR}/obcagent ${D}${sysconfdir}/init.d
}

PACKAGE_ARCH = "${MACHINE_ARCH}"

FILES_${PN} = "${sysconfdir}"

INITSCRIPT_NAME = "obcagent"
INITSCRIPT_PARAMS = "start 22 2 3 4 5 . stop 80 0 6 1 ."
