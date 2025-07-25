# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoff"
ECM_TEST="false"
KDE_ORG_NAME="kde-cli-tools"
KFMIN=9999
QTMIN=6.9.1
inherit ecm plasma.kde.org

DESCRIPTION="Graphical frontend for KDE Frameworks' kdesu"
HOMEPAGE="https://invent.kde.org/plasma/kde-cli-tools"

LICENSE="GPL-2" # TODO: CHECK
SLOT="0"
KEYWORDS=""
IUSE="X"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6=[gui,widgets]
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdesu-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6[X?]
"
RDEPEND="${DEPEND}
	!<${CATEGORY}/${KDE_ORG_NAME}-6.1.4-r2:*[kdesu(+)]
	>=${CATEGORY}/${KDE_ORG_NAME}-common-${PV}
	sys-apps/dbus[X]
"

# downstream split
PATCHES=( "${FILESDIR}/${PN}-6.1.80-build-only-kdesu.patch" )

src_prepare() {
	ecm_src_prepare
	ecm_punt_po_install
}

src_configure() {
	local mycmakeargs=(
		-DWITH_X11=$(usex X)
	)
	ecm_src_configure
}

src_install() {
	ecm_src_install
	dosym ../libexec/kf6/kdesu /usr/bin/kdesu
}
