 
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:${THISDIR}/${PN}/files:"


SRC_URI_append = " \
    file://ntpdate.default \
"
