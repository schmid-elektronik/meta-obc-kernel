FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:${THISDIR}/${PN}/brcm:"

# TODO create own firmware layer
# add firmware files to supplicant package, not clean way
# but at least it's all wifi stuff
FILES_${PN} += "${nonarch_base_libdir}/firmware/brcm/*"

SRC_URI_append = " \
    file://wpa_supplicant.conf-sane \
    file://BCM4373A0-04b4-640c.hcd \
    file://BCM4373A0-usb-sa.hcd \
    file://brcmfmac4373-clm-sa.clm_blob \
    file://brcmfmac4373-usb-sa-prod.bin \
    file://brcmfmac4373.bin \
    file://brcmfmac4373.clm_blob \
"

do_install_append() {
    # supposed to be in firmware package
    install -d ${D}${nonarch_base_libdir}/firmware/brcm
	
	install -m 644 ${WORKDIR}/BCM4373A0-04b4-640c.hcd ${D}${nonarch_base_libdir}/firmware/brcm/
	install -m 644 ${WORKDIR}/BCM4373A0-usb-sa.hcd ${D}${nonarch_base_libdir}/firmware/brcm/
	install -m 644 ${WORKDIR}/brcmfmac4373-clm-sa.clm_blob ${D}${nonarch_base_libdir}/firmware/brcm/
	install -m 644 ${WORKDIR}/brcmfmac4373-usb-sa-prod.bin ${D}${nonarch_base_libdir}/firmware/brcm/
	install -m 644 ${WORKDIR}/brcmfmac4373.bin ${D}${nonarch_base_libdir}/firmware/brcm/
	install -m 644 ${WORKDIR}/brcmfmac4373.clm_blob ${D}${nonarch_base_libdir}/firmware/brcm/

}
