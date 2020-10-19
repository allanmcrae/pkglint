# pkglint
Implementation of namcap rules for libmakepkg

## Status

### Replaced namcap rules

```
anyelf              : Check for ELF files to see if a package should be 'any' architecture
directoryname       : Checks for standard directories.
elfexecstack        : Check for executable stacks in ELF files.
elfgnurelro         : Check for FULL RELRO in ELF files.
elfnopie            : Check for no PIE ELF files.
elfpaths            : Check about ELF files outside some standard paths.
elftextrel          : Check for text relocations in ELF files.
elfunstripped       : Check for unstripped ELF files.
emptydir            : Warns about empty directories in a package
fhs-infopages       : Verifies correct installation of info pages
fhs-manpages        : Verifies correct installation of man pages
licensepkg          : Verifies license is included in a package file
lots-of-docs        : See if a package is carrying more documentation than it should
pkgnameindesc       : Verifies if the package name is included on package description
redundant_makedepends: Check for redundant make dependencies
rpath               : Verifies correct and secure RPATH for files.
systemdlocation     : Checks for systemd files in /etc/systemd/system/
```

### Ignored namcap rules

**Handled by makepkg**
```
array               : Verifies that array variables are actually arrays
badbackups          : Checks for bad backup entries
checksums           : Checks for missing checksums
missingbackups      : Backup files listed in package should exist
splitpkgfunctions   : Checks that all package_* functions exist.
```

**Handled by hooks**
```
giomodules          : Check that GIO modules are registered
glibschemas         : Check that dconf schemas are compiled
hicoloricons        : Checks whether the hicolor icon cache is updated.
infoinstall         : Checks that info files are correctly installed.
mimedesktop         : Check that MIME associations are updated
mimefiles           : Check for files in /usr/share/mime
```

**Other**
```
infodirectory       : Checks for info directory file.
libtool             : Checks for libtool (*.la) files.
perllocal           : Verifies the absence of perllocal.pod.
```

Notes: 
- Arch has PURGE_TARGETS set to remove the info directory file, and *.pod files making those checks obsolete.
- Arch default is `'!libtool'`, so a PKGBUILD explicitly requires `options=('libtool')` to have a libtool file.

### Unhandled namcap rules

**Package Checks**
```
filenames           : Checks for invalid filenames.
fileownership       : Checks file ownership.
gnomemime           : Checks for generated GNOME mime files
hardlinks           : Look for cross-directory/partition hard links
javafiles           : Check for existence of Java classes or JARs
kdeprograms         : Checks that KDE programs have kdebase-runtime as a dependency
permissions         : Checks file permissions.
py_mtime            : Check for py timestamps that are ahead of pyc/pyo timestamps
rubypaths           : Verifies correct usage of folders by ruby packages
scrollkeeper        : Verifies that there aren't any scrollkeeper directories.
shebangdepends      : Checks dependencies semi-smartly.
sodepends           : Checks dependencies caused by linked shared libraries
symlink             : Checks that symlinks point to the right place
unusedsodepends     : Checks for unused dependencies caused by linked shared libraries
```


**PKGBUILD Checks**
```
capsnamespkg        : Verifies package name in package does not include upper case letters
carch               : Verifies that no specific host type is used
description         : Verifies that the description is set in a PKGBUILD
externalhooks       : Check the .INSTALL for commands covered by hooks
extravars           : Verifies that extra variables start with an underscore
hookdepends         : Check for redundant hook dependencies
invalidstartdir     : Looks for references to $startdir
license             : Verifies license is included in a PKGBUILD
makepkgfunctions    : Looks for calls to makepkg functionality
non-unique-source   : Verifies the downloaded sources have a unique filename
pathdepends         : Check for simple implicit path dependencies
sfurl               : Checks for proper sourceforge URLs
splitpkgmakedeps    : Checks that a split PKGBUILD has enough makedeps.
tags                : Looks for Maintainer and Contributor comments
urlpkg              : Verifies url is included in a package file
vcs_makedepends     : Verify make dependencies for VCS sources
```



