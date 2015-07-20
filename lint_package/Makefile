SCRIPTS = \
	any_elf.sh \
	rpath.sh

libmakepkgdir = /usr/share/makepkg

install:
	mkdir -p $(DESTDIR)$(libmakepkgdir)/lint_package
	for lib in $(SCRIPTS); do \
		install -m755 $$lib $(DESTDIR)$(libmakepkgdir)/lint_package; \
	done

.PHONY: install
		