# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit kde5

DESCRIPTION="Plasma 5 applet for monitoring system temperatures"
HOMEPAGE="http://kde-apps.org/content/show.php/Thermal+Monitor?content=170354
https://github.com/kotelnik/plasma-applet-thermal-monitor"

if [[ ${KDE_BUILD_TYPE} = live ]] ; then
	EGIT_REPO_URI="https://github.com/kotelnik/${PN}.git"
else
	SRC_URI="https://github.com/kotelnik/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-2+"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	$(add_frameworks_dep plasma)
"
RDEPEND="${DEPEND}"

DOCS=( README.md )
