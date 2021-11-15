FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:${THISDIR}/${PN}/stm32mp1:"


SRC_URI_append_stm32mp1 = " \
    file://dts/stm32mp157c-qsmp-1570-obc.dtsi;subdir=git/arch/arm/boot \
    file://dts/stm32mp157c-qsmp-1570-bb.dts;subdir=git/arch/arm/boot \
    file://dts/stm32mp157c-qsmp-1570-fin.dts;subdir=git/arch/arm/boot \
"

# some stupid printk debugging messages
#SRC_URI_append = " \
#    file://patch/debugphy.patch \
#    file://patch/generic-debug.patch \
#    file://patch/stmdebug.patch \
#    file://patch/debug_clk.patch \
#"

SRC_URI_append = " \
    file://patch/obc-pinmux.patch \
"

KERNEL_FEATURES_append = " cfg/brcmwifi.cfg"
KERNEL_FEATURES_append = " cfg/dp83848phy.cfg"
KERNEL_FEATURES_append = " cfg/rtc.cfg"
KERNEL_FEATURES_append = " cfg/adc.cfg"
KERNEL_FEATURES_append = " cfg/usb_cdc.cfg"
KERNEL_FEATURES_append = " cfg/serial.cfg"

# debug only
#KERNEL_FEATURES_append = " cfg/trace.cfg"
