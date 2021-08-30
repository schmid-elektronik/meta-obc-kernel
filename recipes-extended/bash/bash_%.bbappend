FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append = " \
	       	  file://bash_aliases\
"
FILES_${PN} += " \
	       ${ROOT_HOME}/.bash_aliases \
"

