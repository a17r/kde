# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
KFMIN=6.5.0
QTMIN=6.7.2
inherit ecm kde.org

if [[ ${KDE_BUILD_TYPE} == release ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Media player with digital TV support by KDE"
HOMEPAGE="https://apps.kde.org/kaffeine/ https://userbase.kde.org/Kaffeine"

LICENSE="GPL-2+ handbook? ( FDL-1.3 )"
SLOT="0"
IUSE="dvb"

COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network,sql,widgets,xml]
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6[X]
	>=kde-frameworks/kxmlgui-${KFMIN}:6
	>=kde-frameworks/solid-${KFMIN}:6
	media-video/vlc[X]
	dvb? ( media-libs/libv4l[dvb] )
"
RDEPEND="${COMMON_DEPEND}
	!${CATEGORY}/${PN}:5
"
DEPEND="${COMMON_DEPEND}
	x11-libs/libXScrnSaver
"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"

DOCS=( Changelog NOTES README.md )

src_configure() {
	# tools working on $HOME directory for a local git checkout
	local mycmakeargs=(
		-DBUILD_TOOLS=OFF
		$(cmake_use_find_package dvb Libdvbv5)
	)

	ecm_src_configure
}
