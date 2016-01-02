# pkglint
Implementation of namcap rules for libmakepkg

## Status

### Replaced namcap rules

```
anyelf              : Check for ELF files to see if a package should be 'any' architecture
directoryname       : Checks for standard directories.
elfpaths            : Check about ELF files outside some standard paths.
fhs-infopages       : Verifies correct installation of info pages
fhs-manpages        : Verifies correct installation of man pages
rpath               : Verifies correct and secure RPATH for files.
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

**Other**
```
infodirectory       : Checks for info directory file.
libtool             : Checks for libtool (*.la) files.
```

Notes: 
- Arch has PURGE_TARGETS set to remove the info directory file, making this check obsolete.
- Arch default is `'!libtool'`, so a PKGBUILD requires `options=('libtool')` to have a libtool file. So there is no need for the libtool warning.

### Unhandled namcap rules

**Package Checks**
```
elfexecstack        : Check for executable stacks in ELF files.
elftextrel          : Check for text relocations in ELF files.
emptydir            : Warns about empty directories in a package
filenames           : Checks for invalid filenames.
fileownership       : Checks file ownership.
giomodules          : Check that GIO modules are registered
glibschemas         : Check that dconf schemas are compiled
gnomemime           : Checks for generated GNOME mime files
hardlinks           : Look for cross-directory/partition hard links
hicoloricons        : Checks whether the hicolor icon cache is updated.
infoinstall         : Checks that info files are correctly installed.
javafiles           : Check for existence of Java classes or JARs
kdeprograms         : Checks that KDE programs have kdebase-runtime as a dependency
licensepkg          : Verifies license is included in a package file
lots-of-docs        : See if a package is carrying more documentation than it should
mimedesktop         : Check that MIME associations are updated
mimefiles           : Check for files in /usr/share/mime
perllocal           : Verifies the absence of perllocal.pod.
permissions         : Checks file permissions.
rubypaths           : Verifies correct usage of folders by ruby packages
scrollkeeper        : Verifies that there aren't any scrollkeeper directories.
shebangdepends      : Checks dependencies semi-smartly.
sodepends           : Checks dependencies caused by linked shared libraries
symlink             : Checks that symlinks point to the right place
```


**PKGBUILD Checks**
```
capsnamespkg        : Verifies package name in package does not include upper case letters
carch               : Verifies that no specific host type is used
extravars           : Verifies that extra variables start with an underscore
invalidstartdir     : Looks for references to $startdir
license             : Verifies license is included in a PKGBUILD
pkgnameindesc       : Verifies if the package name is included on package description
sfurl               : Checks for proper sourceforge URLs
splitpkgmakedeps    : Checks that a split PKGBUILD has enough makedeps.
tags                : Looks for Maintainer and Contributor comments
urlpkg              : Verifies url is included in a package file
```



