#!/usr/bin/bash
#
#   ruby_path.sh - Check for correct usage of folders by ruby packages
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

[[ -n "$LIBMAKEPKG_LINT_PACKAGE_RUBY_PATH_SH" ]] && return
LIBMAKEPKG_LINT_PACKAGE_RUBY_PATH_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"


lint_package_functions+=('check_ruby_path')

check_ruby_path() {
	local dir="usr/lib/ruby/site_ruby"
	local rubydir="usr/lib/ruby/vendor_ruby"

	while read -r filename; do
		if [[ ${filename#$pkgdir/} = "$dir"* ]]; then
			warning "$(gettext "Found '%s' in package, '%s' should be used instead")" "$dir" "$rubydir"
			return
		fi
	done < <(find "$pkgdir" -type f)
}
