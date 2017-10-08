#!/usr/bin/bash
#
#   pkglint.sh - validate package using libmakepkg linting functions
#
#   Copyright (c) 2015 Allan McRae <allan@archlinux.org>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source $LIBRARY/lint_package.sh

if [[ -z "$1" ]]; then
	echo "Usage: pkglint <pkg>"
	exit
fi

pkgdir=$(mktemp -d -t pkglint.XXXXXXXX)

bsdtar -xf $1 -C $pkgdir

# obtain needed information from the .PKGIFNO file
arch=$(sed -n 's/^arch = //p' $pkgdir/.PKGINFO)
backup=($(sed -nr 's/^backup = //p' $pkgdir/.PKGINFO))

# reconstruct base of srcdir from .BUILDINFO file
# full path varies depending on whether BUILDDIR was set during building
srcdir=$(sed -n 's/^builddir = //p' $pkgdir/.BUILDINFO)

# remove dotfiles from package root to avoid false positive results
rm -f $pkgdir/{.BUILDINFO,.INSTALL,.MTREE,.PKGINFO}

lint_package

rm -r $pkgdir
