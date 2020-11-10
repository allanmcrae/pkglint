install:
	cd lint_package && $(MAKE) $@
	cd lint_pkgbuild && $(MAKE) $@

.PHONY: install
