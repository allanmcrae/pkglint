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

tar -xf $1 -C $pkgdir

# obtain the package archtecture from the .PKGINFO file
arch=$(sed -n 's/^arch = //p' $pkgdir/.PKGINFO)

# the build_references check requires variables we are unable to determine the value of
# set them to unlikely values
srcdir=$(mktemp -d -u -t pkglint.srcdir.XXXXXXXX)
pkgdirbase=$(mktemp -d -u -t pkglint.pkgdirbase.XXXXXXXX)

lint_package
