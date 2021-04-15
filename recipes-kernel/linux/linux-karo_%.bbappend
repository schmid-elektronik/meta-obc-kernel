FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/patches:${THISDIR}/${PN}:"

SRC_URI_append = " \
     file://${KBUILD_DEFCONFIG} \
"
