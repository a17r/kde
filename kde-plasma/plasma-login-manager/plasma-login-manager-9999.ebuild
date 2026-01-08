# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.14.0
QTMIN=6.7.2
inherit ecm plasma.kde.org linux-info pam systemd tmpfiles

DESCRIPTION="Simple Desktop Display Manager"
HOMEPAGE="https://invent.kde.org/plasma/plasma-login-manager"

LICENSE="GPL-2+ MIT CC-BY-3.0 CC-BY-SA-3.0 public-domain"
SLOT="0"
IUSE="+elogind systemd test +X"

REQUIRED_USE="^^ ( elogind systemd )"
RESTRICT="!test? ( test )"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=kde-frameworks/kauth-${KFMIN}:6
	>=kde-frameworks/kcmutils-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kpackage-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-plasma/plasma-workspace-${KFMIN}:6
	>=kde-plasma/layer-shell-qt-${KFMIN}:6
	>=kde-plasma/libplasma-${KFMIN}:6
	sys-libs/pam
	x11-libs/libXau
	x11-libs/libxcb:=
	elogind? ( sys-auth/elogind[pam] )
	systemd? ( sys-apps/systemd:=[pam] )
"
RDEPEND="${DEPEND}
	X? ( x11-base/xorg-server )
	!systemd? ( gui-libs/display-manager-init )
"
BDEPEND="
	dev-python/docutils
	>=dev-build/cmake-3.25.0
	>=dev-qt/qttools-${QTMIN}[linguist]
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
"

pkg_setup() {
	local CONFIG_CHECK="~DRM"
	use kernel_linux && linux-info_pkg_setup
}

src_prepare() {
	touch 01gentoo.conf || die

cat <<-EOF >> 01gentoo.conf
[General]
# Remove qtvirtualkeyboard as InputMethod default
InputMethod=
EOF

	cmake_src_prepare

	if ! use test; then
		sed -e "/^find_package/s/ Test//" -i CMakeLists.txt || die
		cmake_comment_add_subdirectory test
	fi

	if use systemd; then
		sed -e "/pam_elogind.so/s/elogind/systemd/" \
			-i "${WORKDIR}"/${PAM_TAR}/${PN}-greeter.pam || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_MAN_PAGES=ON
		-DRUNTIME_DIR=/run/sddm
		-DSYSTEMD_TMPFILES_DIR="/usr/lib/tmpfiles.d"
		-DNO_SYSTEMD=$(usex !systemd)
		-DUSE_ELOGIND=$(usex elogind)
		# try to use VT7 first.
		# Keep the same as CHECKVT from display-manager
		-DPLASMALOGIN_INITIAL_VT=7
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	insinto /etc/sddm.conf.d/
	doins "${S}"/01gentoo.conf

	# with systemd logs are sent to journald, so no point to bother in that case
	if ! use systemd; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}/sddm.logrotate" sddm
	fi

	newpamd "${WORKDIR}"/${PAM_TAR}/${PN}.pam ${PN}
	newpamd "${WORKDIR}"/${PAM_TAR}/${PN}-autologin.pam ${PN}-autologin
	newpamd "${WORKDIR}"/${PAM_TAR}/${PN}-greeter.pam ${PN}-greeter
}
