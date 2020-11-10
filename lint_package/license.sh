#!/usr/bin/bash
#
#   license.sh - Check if a package includes a license
#
#   Copyright (c) 2020 Michael Straube <michael.straubej@gmail.com>
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

[[ -n "$LIBMAKEPKG_LINT_PACKAGE_LICENSE_SH" ]] && return
LIBMAKEPKG_LINT_PACKAGE_LICENSE_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/util.sh"


lint_package_functions+=('check_license')

check_license() {
	if (( ${#license[@]} == 0 )); then
		error "$(gettext "Missing license")"
		return
	fi

	for l in "${license[@]}"; do
		local common=(/usr/share/licenses/common/*)
		local uncommon=(bsd mit isc python zlib libpng)
		local licensedir="usr/share/licenses"

		if [[ ${l,,} = "custom"* ]] || in_array "${l,,}" "${uncommon[@]}"; then
			if ! [[ -d "$pkgdir/$licensedir/$pkgname" ]]; then
				error "$(gettext "Missing custom license directory '%s'")" "$licensedir/$pkgname"
			elif dir_is_empty "$pkgdir/$licensedir/$pkgname"; then
				error "$(gettext "Missing custom license file in '%s'")" "$licensedir/$pkgname/"
			fi
		else # A common license
			if ! in_array "/$licensedir/common/$l" "${common[@]}"; then
				error "$(gettext "'%s' is not a common license (it's not in /usr/share/licenses/common/)")" "$l"
			fi
		fi
	done
}
