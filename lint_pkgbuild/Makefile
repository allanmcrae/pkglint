SCRIPTS = \
	makepkg_functions.sh

libmakepkgdir = /usr/share/makepkg

install:
	mkdir -p $(DESTDIR)$(libmakepkgdir)/lint_pkgbuild
	for lib in $(SCRIPTS); do \
		install -m755 $$lib $(DESTDIR)$(libmakepkgdir)/lint_pkgbuild; \
	done

.PHONY: install
