SCRIPTS = \
	any_elf.sh \
	elf_location.sh \
	empty_dir.sh \
	fhs_misc.sh \
	fhs_root.sh \
	fhs_usr.sh \
	rpath.sh

libmakepkgdir = /usr/share/makepkg

install:
	mkdir -p $(DESTDIR)$(libmakepkgdir)/lint_package
	for lib in $(SCRIPTS); do \
		install -m755 $$lib $(DESTDIR)$(libmakepkgdir)/lint_package; \
	done

.PHONY: install
