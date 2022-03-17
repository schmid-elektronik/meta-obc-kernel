FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://brcmfmac.conf  \
"

do_install_append () {
    install -d  ${D}${sysconfdir}/modprobe.d
	install -m 600 ${WORKDIR}/brcmfmac.conf ${D}${sysconfdir}/modprobe.d/brcmfmac.conf
}
