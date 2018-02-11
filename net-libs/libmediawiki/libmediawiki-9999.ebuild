# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit kde5

DESCRIPTION="C++ interface for MediaWiki based web service as wikipedia.org"
HOMEPAGE="https://www.digikam.org/"

LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_qt_dep qtnetwork)
"
RDEPEND="${DEPEND}
	!net-libs/libmediawiki:4
"

PATCHES=( "${FILESDIR}/${PN}-5.0.0_pre20170128-tests-optional.patch" )

src_test() {
	# bug 646808
	local myctestargs=(
		-j1
		-E "(libmediawiki-logintest|libmediawiki-queryimageinfotest)"
	)
	kde5_src_test
}
