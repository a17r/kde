# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OpenPGP keys used to sign main KDE product releases"
HOMEPAGE="https://kde.org/"
SRC_URI="
	http://pgp.mit.edu/pks/lookup?op=get&search=0xD81C0CB38EB725EF6691C385BB463350D6EF31EF
		-> heiko.becker@kde.org.key
"
#	https://keys.openpgp.org/vks/v1/by-fingerprint/53E6B47B45CEA3E0D5B7457758D0EE648A48B3BB
#		-> faure@kde.org.key
#	https://keys.openpgp.org/vks/v1/by-fingerprint/2D1D5B0588357787DE9EE225EC94D18F7F05997E
#		-> jr@jriddell.org.key
#	https://keys.openpgp.org/vks/v1/by-fingerprint/0AAC775BB6437A8D9AF7A3ACFE0784117FBCE11D
#		-> bshah@kde.org.key
#	https://keys.openpgp.org/vks/v1/by-fingerprint/D07BD8662C56CB291B316EB2F5675605C74E02CF
#		-> davidedmundson@kde.org.key
#	https://keys.openpgp.org/vks/v1/by-fingerprint/1FA881591C26B276D7A5518EEAAF29B42A678C20
#		-> notmart@gmail.com.key
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

src_install() {
	local files=( ${A} )
	insinto /usr/share/openpgp-keys
	newins - kde.org.asc < <(cat "${files[@]/#/${DISTDIR}/}")
}
