

# another weird functionality https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#var-PACKAGECONFIG
# PACKAGECONFIG[foo] = "--enable-foo,--disable-foo,foo_depends,foo_runtime_depends,foo_runtime_recommends,foo_conflict_packageconfig"


PACKAGECONFIG = "ssl dns-srv\
                  ${@bb.utils.filter('DISTRO_FEATURES','systemd', d)} \
                  "
