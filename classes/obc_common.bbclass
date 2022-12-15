FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DESCRIPTION = "OBC common paths constants \
   - installs obc bin and conf paths \
   - includes binaries archive \
"

HOMEPAGE = "schmid-elektronik.ch"
LICENSE = "GPL-3.0"
SECTION = "base"
DEPENDS = ""
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-3.0;md5=c79ff39f19dfec6d293b95dea7b07891"

OBC_PATH_HOME = "/app"
OBC_PATH_BIN = "/app/bin"
OBC_PATH_CONF = "/app/conf"
OBC_PATH_LOG = "/mnt/log"

# external source for sh binaries
# TODO get them from git release

# archives are automatically extcted in do_unpack
# [Fetching code](https://docs.yoctoproject.org/singleindex.html#fetching-code)
SRC_URI_append = " \
    file:///${BSPDIR}/release/obc-services-karo_1.1.12.tar.gz \
"

do_install_prepend () {
    install -d ${D}/${OBC_PATH_HOME}
    install -d ${D}/${OBC_PATH_BIN}
    install -d ${D}/${OBC_PATH_CONF}
    install -d ${D}/${OBC_PATH_LOG}
}

PACKAGE_ARCH = "${MACHINE_ARCH}"

RDEPENDS_${PN} = " \
    bash \
    libmosquitto1 \
    libmosquittopp1 \
    boost \
    c-ares \
    libssl \
"

DEPENDS = " \
    boost \
"

FILES_${PN} += "${OBC_BIN_PATH} ${OBC_PATH_HOME} ${OBC_PATH_CONF} ${OBC_PATH_LOG}"


