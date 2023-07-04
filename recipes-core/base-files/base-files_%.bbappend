FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://hosts \
"

# overwrite hosts file
do_install_append_qsmp-1530-bb () {
    install -m 0644 ${WORKDIR}/hosts ${D}${sysconfdir}/hosts
}

do_install_append_qsmp-1530-fin () {
    install -m 0644 ${WORKDIR}/hosts ${D}${sysconfdir}/hosts
}

