# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

DESCRIPTION="A floating-point formalization for the Coq system."
HOMEPAGE="http://flocq.gforge.inria.fr/"
SRC_URI="https://gforge.inria.fr/frs/download.php/28389/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="sci-mathematics/coq"

src_configure() {
	econf --libdir="`coqc -where`/user-contrib/Flocq"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc NEWS README AUTHORS ChangeLog
}

