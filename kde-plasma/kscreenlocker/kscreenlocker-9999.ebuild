# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="forceoptional"
KFMIN=5.245.0
PVCUT=$(ver_cut 1-3)
QTMIN=6.6.0
inherit ecm plasma.kde.org pam

DESCRIPTION="Library and components for secure lock screen architecture"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS=""
IUSE=""

RESTRICT="test"

COMMON_DEPEND="
	dev-libs/wayland
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=kde-frameworks/kcmutils-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6[qml]
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/kdeclarative-${KFMIN}:6
	>=kde-frameworks/kglobalaccel-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kidletime-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/kpackage-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-frameworks/kxmlgui-${KFMIN}:6
	>=kde-frameworks/solid-${KFMIN}:6
	>=kde-plasma/kwayland-${PVCUT}:6
	>=kde-plasma/layer-shell-qt-${PVCUT}:6
	>=kde-plasma/libkscreen-${PVCUT}:6
	sys-libs/pam
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libxcb
	x11-libs/xcb-util-keysyms
"
DEPEND="${COMMON_DEPEND}
	x11-base/xorg-proto
"
RDEPEND="${COMMON_DEPEND}
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-plasma/libplasma-${PVCUT}:6
"
BDEPEND="
	dev-util/wayland-scanner
	>=kde-frameworks/kcmutils-${KFMIN}:6
"
PDEPEND=">=kde-plasma/kde-cli-tools-${PVCUT}:*"

src_prepare() {
	ecm_src_prepare
	use test || cmake_run_in greeter cmake_comment_add_subdirectory autotests
}

src_test() {
	# requires running environment
	local myctestargs=(
		-E x11LockerTest
	)
	ecm_src_test
}

src_install() {
	ecm_src_install

	newpamd "${FILESDIR}/kde.pam" kde
	newpamd "${FILESDIR}/kde-np.pam" kde-np
}
