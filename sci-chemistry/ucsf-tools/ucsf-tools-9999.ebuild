# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

AUTOTOOLS_AUTORECONF=y

inherit autotools-utils

DESCRIPTION="The USF program suite"
HOMEPAGE="http://xray.bmc.uu.se/usf/"
SRC_URI="
	http://xray.bmc.uu.se/markh/usf/usf_distribution_kit.tar.gz -> ${P}.tar.gz
	http://dev.gentoo.org/~jlec/distfiles/mark-20110912.tgz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
"

S="${WORKDIR}"/usf_export

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	unpack mark-20110912.tgz
}
