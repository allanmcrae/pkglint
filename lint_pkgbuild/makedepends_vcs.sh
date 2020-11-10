#!/usr/bin/bash
#
#   makedepends_vcs.sh - Check for missing VCS make dependencies
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

[[ -n "$LIBMAKEPKG_LINT_PKGBUILD_MAKEDEPENDS_VCS_SH" ]] && return
LIBMAKEPKG_LINT_PKGBUILD_MAKEDEPENDS_VCS_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/pkgbuild.sh"
source "$LIBRARY/util/source.sh"
source "$LIBRARY/util/util.sh"


lint_pkgbuild_functions+=('check_makedepends_vcs')

check_makedepends_vcs() {
	local netfile proto vcsdep
	local all_sources

	get_all_sources 'all_sources'

	for netfile in "${all_sources[@]}"; do
		proto="$(get_protocol "$netfile")"

		case $proto in
			bzr)	vcsdep="bzr" ;;
			git)	vcsdep="git" ;;
			hg)	vcsdep="mercurial" ;;
			svn)	vcsdep="subversion" ;;
			*)	continue ;;
		esac

		in_array "$vcsdep" "${depends[@]}" && continue

		if ! in_array "$vcsdep" "${makedepends[@]}"; then
			error "$(gettext "PKGBUILD lacks make dependency '%s' for VCS sources")" "$vcsdep"
			return 1
		fi
	done
}
