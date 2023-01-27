FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://interfaces \
    file://interfaces-bb \
    file://interfaces-fin \
"

# add can interface to initalisation
SRC_URI_append_qsmp-1530-bb = " \
    file://init-bb \
"
SRC_URI_append_qsmp-1570-bb = " \
    file://init-bb \
"

# overwrite interface settings
do_install_append_qsmp-1530-bb () {
    install -m 0755 ${WORKDIR}/init-bb ${D}${sysconfdir}/init.d/networking
    install -m 0644 ${WORKDIR}/interfaces-bb ${D}${sysconfdir}/network/interfaces
}
do_install_append_qsmp-1570-bb () {
    install -m 0755 ${WORKDIR}/init-bb ${D}${sysconfdir}/init.d/networking
    install -m 0644 ${WORKDIR}/interfaces-bb ${D}${sysconfdir}/network/interfaces
}

do_install_append_qsmp-1570-fin () {
    install -m 0644 ${WORKDIR}/interfaces-fin ${D}${sysconfdir}/network/interfaces
}
