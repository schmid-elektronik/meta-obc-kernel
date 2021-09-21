FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:${THISDIR}/${PN}/stm32mp1:"


SRC_URI_append_stm32mp1 = " \
    file://dts/stm32mp157c-qsmp-1570-obc.dts;subdir=git/arch/arm/boot \
"

#SRC_URI_append = " \
#    file://patch/debugphy.patch \
#    file://patch/generic-debug.patch \
#"

KERNEL_FEATURES_append = "${@bb.utils.contains('DISTRO_FEATURES',"wifi"," cfg/brcmwifi.cfg","",d)}"
KERNEL_FEATURES_append = " cfg/dp83848phy.cfg"


# debug only 
#KERNEL_FEATURES_append = " cfg/trace.cfg"


KERNEL_DEVICETREE_append_qsmp-1570 = " \
    stm32mp157c-qsmp-1570-obc.dtb \
"
