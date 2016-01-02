#!/usr/bin/bash
#
#   fhs_root.sh - Warn about miscellaneous FHS violations
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

[[ -n "$LIBMAKEPKG_LINT_PACKAGE_FHS_MISC_SH" ]] && return
LIBMAKEPKG_LINT_PACKAGE_FHS_MISC_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/util.sh"


lint_package_functions+=('warn_fhs_misc')

warn_fhs_misc() {
	local opt_dirs=('bin' 'doc' 'include' 'info' 'lib' 'man')
	local var_dirs_empty=('lock' 'run' 'tmp')

	# packages should install to (e.g.) opt/$pkgname
	for d in ${opt_dirs[@]}; do
		if [[ -d $pkgdir/opt/$d ]]; then
			warning "$(gettext "Packages using '%s' should place files in '%s'")" "opt/" 'opt/$pkgname/'
		fi
	done

	# these directories should not contain files
	for d in ${var_dirs_empty[@]}; do
		if [[ -d $pkgdir/var/$d ]]; then
			if (( $(find $pkgdir/var/$d -maxdepth 1 -mindepth 1 | wc -l) != 0 )); then
				warning "$(gettext "Package directory '%s' should be empty")" "var/$d/"
			fi
		fi
	done
}
