# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: Alexey Shvetsov <alexxy@gentoo.org>
# Purpose:  Simplify working with OFED packages
#

HOMEPAGE="http://www.openfabrics.org/"
LICENSE="|| ( GPL-2 BSD-2 )"
SLOT="0"

inherit rpm eutils

case ${OFED_VER} in
	1.4*)
		SRC_URI="http://www.openfabrics.org/downloads/OFED/ofed-1.4/OFED-1.4.tgz"
		;;
esac

EXPORT_FUNCTIONS src_unpack

# @FUNCTION: openib_src_unpack
# @DESCRIPTION:
# This function will unpack OFED packages
openib_src_unpack() {
	unpack ${A}
	rpm_unpack "OFED-${OFED_VER}/SRPMS/${P}-${ofs}.rpm"
	unpack ./${P}.tar.gz
}
