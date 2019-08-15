# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="true"
VIRTUALX_REQUIRED="test"
PVCUT=$(ver_cut 1-3)
FRAMEWORKS_MINIMAL=5.60.0
QT_MINIMAL=5.12.3
inherit kde5

DESCRIPTION="Library for gravatar integration"
LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-frameworks/kconfig-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ki18n-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kio-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/ktextwidgets-${FRAMEWORKS_MINIMAL}:5
	>=kde-frameworks/kwidgetsaddons-${FRAMEWORKS_MINIMAL}:5
	>=kde-apps/pimcommon-${PVCUT}:5
	>=dev-qt/qtgui-${QT_MINIMAL}:5
	>=dev-qt/qtnetwork-${QT_MINIMAL}:5
	>=dev-qt/qtwidgets-${QT_MINIMAL}:5
"
RDEPEND="${DEPEND}
	!kde-apps/kdepim-l10n
"

src_test() {
	# bug 624584 - needs internet connection
	local myctestargs=(
		-E "(gravatar-gravatarresolvurljobtest)"
	)
	kde5_src_test
}
