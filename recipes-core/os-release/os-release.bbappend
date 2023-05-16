FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

BUILD_ID = "${@time.strftime('%Y-%m-%d %H:%M:%S',time.localtime())}"

OS_RELEASE_FIELDS_append = " BUILD_ID LAYERSERIES_CORENAMES"

