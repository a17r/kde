# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
KFMIN=9999
QTMIN=6.9.1
inherit ecm plasma.kde.org optfeature xdg

DESCRIPTION="Utility providing information about the computer hardware"
HOMEPAGE="https://userbase.kde.org/KInfoCenter"
SRC_URI+=" https://www.gentoo.org/assets/img/logo/gentoo-3d-small.png -> glogo-small.png"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS=""
IUSE="gles2-only usb"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gles2-only=,gui,vulkan,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=kde-frameworks/kauth-${KFMIN}:6
	>=kde-frameworks/kcmutils-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	virtual/libudev:=
	gles2-only? ( >=media-libs/mesa-24.1.0_rc1[opengl] )
	usb? ( virtual/libusb:1 )
"
RDEPEND="${DEPEND}
	>=dev-qt/qttools-${QTMIN}:6[qdbus]
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-plasma/systemsettings-${KDE_CATV}:6
"
BDEPEND="
	>=kde-frameworks/kcmutils-${KFMIN}:6
	virtual/pkgconfig
"

CMAKE_SKIP_TESTS=(
	# bug 816591
	smbmountmodeltest
)

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package usb USB1)
	)

	ecm_src_configure
}

src_install() {
	ecm_src_install

	# TODO: Make this fully obsolete by /etc/os-release
	insinto /etc/xdg
	doins "${FILESDIR}"/kcm-about-distrorc

	insinto /usr/share/${PN}
	doins "${DISTDIR}"/glogo-small.png
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		optfeature_header "Query network filesystem info:"
		optfeature "NFS information module" net-fs/nfs-utils
		optfeature "Samba status information module" net-fs/samba
		optfeature_header "Query firmware/hardware info:"
	fi
	optfeature "System DMI table readout" sys-apps/dmidecode
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		optfeature "Firmware security module" "app-text/aha sys-apps/fwupd"
		optfeature "PCI devices information module" sys-apps/pciutils
		optfeature "advanced CPU information module" sys-apps/util-linux
		optfeature_header "Query GPU/graphics support info:"
	fi
	optfeature "OpenCL information module" dev-util/clinfo
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		optfeature "OpenGL information module" x11-apps/mesa-progs
		optfeature "Vulkan graphics API information module" dev-util/vulkan-tools
		optfeature "Wayland information module" app-misc/wayland-utils
		optfeature "X Server information module" x11-apps/xdpyinfo
	fi
	xdg_pkg_postinst
}
