LICENSE = "MIT"

inherit core-image rootfs-postprocess relative_symlinks

ROOTFS_POSTPROCESS_COMMAND_remove = "\
                                     rootfs_update_timestamp; \
                                     ${bb.utils.contains('DISTRO_FEATURES','read-only-rootfs','empty_var_volatile;','',d)} \
"

# note rpm uses a lot of space (IMAGE_ROOTFS_EXTRA_SPACE)
IMAGE_INSTALL_append = " \
                        rpm \
                        bash \
                        canutils \
                        coreutils \
                        c-ares \
                        dhcpcd \
                        dosfstools \
                        e2fsprogs \
                        e2fsprogs-resize2fs \
                        file \
                        gdb \
                        gdbserver \
                        i2c-tools \
                        kmod \
                        python3-core \
                        ldd \
                        less \
                        libstdc++ \
                        libgpiod \
                        libgpiod-tools \
                        nfs-utils \
                        libmodbus \
                        lsof \
                        mmc-utils \
                        ncurses \
                        parted \
                        pciutils \
                        rsync \
                        strace \
                        tcp-wrappers \
                        tzdata \
                        util-linux-fsck \
                        util-linux-mkfs \
                        util-linux-setterm \
                        udev \
                        boost \
                        libmosquitto1 \
                        libmosquittopp1 \
                        mosquitto-clients \
                        ca-certificates \
                        unzip \
                        zip \
                        iw \
                        iptables \
                        ufw \
                        ethtool \
                        tcpdump \
                        util-linux \
                        procps \
                        chrony \
                        screen \
                        picocom \
                        iproute2 \
                        net-tools \
                        bash-completion \
"

DEPENDS_append = " cross-localedef-native qemuwrapper-cross"

#CORE_IMAGE_EXTRA_INSTALL_append = " kernel-modules"
DEPENDS_append = " u-boot-karo"

PREFERRED_PROVIDER_fdisk = "util-linux"
PREFERRED_PROVIDER_virtual/bootloader = "u-boot-karo"
PREFERRED_PROVIDER_virtual/kernel = "linux-karo"

IMAGE_ROOTFS_SIZE ?= "${@${ROOTFS_PARTITION_SIZE}-(${IMAGE_ROOTFS_EXTRA_SPACE})}"

IMAGE_ROOTFS_ALIGNMENT = "128"
IMAGE_OVERHEAD_FACTOR = "1"

IMAGE_FSTYPES_remove = "tar.gz"
IMAGE_FSTYPES_append = " tar.bz2"
IMAGE_FSTYPES_append = "${@bb.utils.contains('MACHINE_FEATURES',"emmc"," ext4","",d)}"


