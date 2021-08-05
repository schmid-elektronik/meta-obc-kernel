FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

KERNEL_FEATURES_append = "${@bb.utils.contains('DISTRO_FEATURES',"wifi"," cfg/brcmwifi.cfg","",d)}"
