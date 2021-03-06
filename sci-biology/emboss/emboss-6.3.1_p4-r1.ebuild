# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/emboss/emboss-6.3.1_p4.ebuild,v 1.2 2011/03/09 16:29:05 jlec Exp $

EAPI="4"

inherit emboss eutils

EBO_PATCH="4"
EBOV=${PV/_p*}

DESCRIPTION="The European Molecular Biology Open Software Suite - A sequence analysis package"
SRC_URI="
	ftp://emboss.open-bio.org/pub/EMBOSS/EMBOSS-${EBOV}.tar.gz
	http://dev.gentoo.org/~jlec/distfiles/${PF}.patch.bz2"
##[[ -n ${EBO_PATCH} ]] && SRC_URI+=" ftp://${PN}.open-bio.org/pub/EMBOSS/fixes/patches/patch-1-${EBO_PATCH}.gz -> ${P}-upstream.patch.gz"
[[ -n ${EBO_PATCH} ]] && SRC_URI+=" http://pkgs.fedoraproject.org/lookaside/pkgs/EMBOSS/patch-1-4.gz/7a42594c5eda4adc6457f33e4ab0d8f2/patch-1-${EBO_PATCH}.gz -> ${P}-upstream.patch.gz"

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE+=" minimal"

RDEPEND+=" !sys-devel/cons"
PDEPEND+="
	!minimal? (
		sci-biology/aaindex
		sci-biology/cutg
		sci-biology/prints
		sci-biology/prosite
		sci-biology/rebase
		sci-biology/transfac
		)"

S="${WORKDIR}"/EMBOSS-${EBOV}

EBO_EXTRA_ECONF="--includedir=${EPREFIX}/usr/include/emboss"

DOCS+=" FAQ THANKS"

src_prepare() {
	[[ -n ${EBO_PATCH} ]] && epatch "${WORKDIR}"/${P}-upstream.patch
	epatch "${WORKDIR}"/${PF}.patch
	epatch "${FILESDIR}/${PF}_plcol.patch"
	emboss_src_prepare
}

src_install() {
	default

	sed -e "s:EPREFIX:${EPREFIX}:g" "${FILESDIR}"/${PN}-README.Gentoo-2 > README.Gentoo && \
	dodoc README.Gentoo

	# Install env file for setting libplplot and acd files path.
	cat <<- EOF > 22emboss
		# ACD files location
		EMBOSS_ACDROOT="${EPREFIX}/usr/share/EMBOSS/acd"
		EMBOSS_DATA="${EPREFIX}/usr/share/EMBOSS/data"
	EOF
	doenvd 22emboss

	# Clashes #330507, resolved upstream
	mv "${ED}"/usr/bin/{digest,pepdigest} || die

	# Remove useless dummy files from the image.
	find "${ED}"/usr/share/EMBOSS -name dummyfile -delete || die "Failed to remove dummy files."

	# Move the provided codon files to a different directory. This will avoid
	# user confusion and file collisions on case-insensitive file systems (see
	# bug #115446). This change is documented in "README.Gentoo".
	mv "${ED}"/usr/share/EMBOSS/data/CODONS{,.orig} || \
			die "Failed to move CODON directory."

	# Move the provided restriction enzyme prototypes file to a different name.
	# This avoids file collisions with versions of rebase that install their
	# own enzyme prototypes file (see bug #118832).
	mv "${ED}"/usr/share/EMBOSS/data/embossre.equ{,.orig} || \
			die "Failed to move enzyme equivalence file."
}
