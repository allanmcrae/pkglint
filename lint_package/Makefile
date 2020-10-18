SCRIPTS = \
	any_elf.sh \
	description.sh \
	elf_location.sh \
	elf_unstripped.sh \
	empty_dir.sh \
	fhs_misc.sh \
	fhs_root.sh \
	fhs_usr.sh \
	license.sh \
	lots_of_docs.sh \
	makedepends.sh \
	rpath.sh \
	systemd_location.sh

libmakepkgdir = /usr/share/makepkg

install:
	mkdir -p $(DESTDIR)$(libmakepkgdir)/lint_package
	for lib in $(SCRIPTS); do \
		install -m755 $$lib $(DESTDIR)$(libmakepkgdir)/lint_package; \
	done

.PHONY: install
