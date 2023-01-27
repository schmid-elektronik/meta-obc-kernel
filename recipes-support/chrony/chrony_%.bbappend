FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# configure Backbone chrony so that it gets the time from fin
SRC_URI_append_qsmp-1530-bb = " \
    file://chrony.conf.bb \
"
SRC_URI_append_qsmp-1570-bb = " \
    file://chrony.conf.bb \
"

# for Fin chrony allow local devices to sync times 
SRC_URI_append_qsmp-1570-fin = " \
    file://chrony.conf.fin \
"

do_install_append_qsmp-1530-bb () {
    # Config file
    install -d ${D}${sysconfdir}
    install -m 644 ${WORKDIR}/chrony.conf.bb ${D}${sysconfdir}/chrony.conf
}
do_install_append_qsmp-1570-bb () {
    # Config file
    install -d ${D}${sysconfdir}
    install -m 644 ${WORKDIR}/chrony.conf.bb ${D}${sysconfdir}/chrony.conf
}

do_install_append_qsmp-1570-fin () {
    # Config file
    install -d ${D}${sysconfdir}
    install -m 644 ${WORKDIR}/chrony.conf.fin ${D}${sysconfdir}/chrony.conf
}
