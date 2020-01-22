# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v2.0.0](https://github.com/voxpupuli/puppet-pxe/tree/v2.0.0) (2020-01-22)

[Full Changelog](https://github.com/voxpupuli/puppet-pxe/compare/1.0.1...v2.0.0)

**Breaking changes:**

- modulesync 2.10.1 [\#52](https://github.com/voxpupuli/puppet-pxe/pull/52) ([dhoppe](https://github.com/dhoppe))

**Closed issues:**

- syslinux url is no longer valid [\#49](https://github.com/voxpupuli/puppet-pxe/issues/49)

**Merged pull requests:**

- Update from xaque208 modulesync\_config [\#48](https://github.com/voxpupuli/puppet-pxe/pull/48) ([xaque208](https://github.com/xaque208))
- Update from xaque208 modulesync\_config [\#47](https://github.com/voxpupuli/puppet-pxe/pull/47) ([xaque208](https://github.com/xaque208))

## [1.0.1](https://github.com/voxpupuli/puppet-pxe/tree/1.0.1) (2019-02-27)

[Full Changelog](https://github.com/voxpupuli/puppet-pxe/compare/1.0.0...1.0.1)

**Closed issues:**

- Make "menu\_tools" optional [\#44](https://github.com/voxpupuli/puppet-pxe/issues/44)

**Merged pull requests:**

- Update from xaque208 modulesync\_config [\#46](https://github.com/voxpupuli/puppet-pxe/pull/46) ([xaque208](https://github.com/xaque208))
- Make `tools` menu optional [\#45](https://github.com/voxpupuli/puppet-pxe/pull/45) ([alexizmailov](https://github.com/alexizmailov))

## [1.0.0](https://github.com/voxpupuli/puppet-pxe/tree/1.0.0) (2018-05-27)

[Full Changelog](https://github.com/voxpupuli/puppet-pxe/compare/0.4.0...1.0.0)

**Merged pull requests:**

- Update from xaque208 modulesync\_config [\#43](https://github.com/voxpupuli/puppet-pxe/pull/43) ([xaque208](https://github.com/xaque208))
- Adding a syslinux version parameter to support older versions of syslinux. [\#42](https://github.com/voxpupuli/puppet-pxe/pull/42) ([mikkergimenez](https://github.com/mikkergimenez))
- modulesync 1.9.0-16-gc46b42a [\#41](https://github.com/voxpupuli/puppet-pxe/pull/41) ([xaque208](https://github.com/xaque208))

## [0.4.0](https://github.com/voxpupuli/puppet-pxe/tree/0.4.0) (2017-09-23)

[Full Changelog](https://github.com/voxpupuli/puppet-pxe/compare/0.3.0...0.4.0)

**Closed issues:**

- Failed to parse inline template: undefined local variable or method `arch' [\#34](https://github.com/voxpupuli/puppet-pxe/issues/34)

**Merged pull requests:**

- use new syntax \(lint warn\) and remove unused files [\#38](https://github.com/voxpupuli/puppet-pxe/pull/38) ([PascalBourdier](https://github.com/PascalBourdier))
- Update the readme for pxe::installer usage [\#37](https://github.com/voxpupuli/puppet-pxe/pull/37) ([xaque208](https://github.com/xaque208))

## [0.3.0](https://github.com/voxpupuli/puppet-pxe/tree/0.3.0) (2017-01-30)

[Full Changelog](https://github.com/voxpupuli/puppet-pxe/compare/0.2.0...0.3.0)

**Closed issues:**

- Add tests [\#35](https://github.com/voxpupuli/puppet-pxe/issues/35)
- Migrating from 0.1.1 to 0.1.2 [\#25](https://github.com/voxpupuli/puppet-pxe/issues/25)
- Bugs in per-machine menus [\#16](https://github.com/voxpupuli/puppet-pxe/issues/16)

**Merged pull requests:**

- Fix \#35 Begin unit testing [\#36](https://github.com/voxpupuli/puppet-pxe/pull/36) ([xaque208](https://github.com/xaque208))
- correct bug when validating mfsbsd images [\#33](https://github.com/voxpupuli/puppet-pxe/pull/33) ([cruwe](https://github.com/cruwe))

## [0.2.0](https://github.com/voxpupuli/puppet-pxe/tree/0.2.0) (2016-12-29)

[Full Changelog](https://github.com/voxpupuli/puppet-pxe/compare/0.1.5...0.2.0)

**Merged pull requests:**

- Fix JSON gem dependencies for Ruby [\#31](https://github.com/voxpupuli/puppet-pxe/pull/31) ([xaque208](https://github.com/xaque208))
- add mfsbsd variants, ver \> 10, docs and validation [\#30](https://github.com/voxpupuli/puppet-pxe/pull/30) ([cruwe](https://github.com/cruwe))

## [0.1.5](https://github.com/voxpupuli/puppet-pxe/tree/0.1.5) (2016-04-22)

[Full Changelog](https://github.com/voxpupuli/puppet-pxe/compare/0.1.4...0.1.5)

**Closed issues:**

- Release 0.1.4 [\#28](https://github.com/voxpupuli/puppet-pxe/issues/28)

**Merged pull requests:**

- do not hardcode template [\#29](https://github.com/voxpupuli/puppet-pxe/pull/29) ([oasys](https://github.com/oasys))

## [0.1.4](https://github.com/voxpupuli/puppet-pxe/tree/0.1.4) (2016-04-18)

[Full Changelog](https://github.com/voxpupuli/puppet-pxe/compare/0.1.3...0.1.4)

**Merged pull requests:**

- Remove references to concat::setup [\#27](https://github.com/voxpupuli/puppet-pxe/pull/27) ([djjudas21](https://github.com/djjudas21))

## [0.1.3](https://github.com/voxpupuli/puppet-pxe/tree/0.1.3) (2016-04-04)

[Full Changelog](https://github.com/voxpupuli/puppet-pxe/compare/0.1.2...0.1.3)

**Merged pull requests:**

- Update testing to include puppet4 [\#26](https://github.com/voxpupuli/puppet-pxe/pull/26) ([xaque208](https://github.com/xaque208))

## [0.1.2](https://github.com/voxpupuli/puppet-pxe/tree/0.1.2) (2015-09-15)

[Full Changelog](https://github.com/voxpupuli/puppet-pxe/compare/0.1.1...0.1.2)

**Closed issues:**

- Multiple issues when specifying images [\#14](https://github.com/voxpupuli/puppet-pxe/issues/14)

**Merged pull requests:**

- Update to use ver 6.03 of syslinux [\#24](https://github.com/voxpupuli/puppet-pxe/pull/24) ([pjfoley](https://github.com/pjfoley))

## [0.1.1](https://github.com/voxpupuli/puppet-pxe/tree/0.1.1) (2015-06-14)

[Full Changelog](https://github.com/voxpupuli/puppet-pxe/compare/0.1.0...0.1.1)

**Merged pull requests:**

- Allow using different Ubuntu netboots [\#23](https://github.com/voxpupuli/puppet-pxe/pull/23) ([dmsimard](https://github.com/dmsimard))
- added support for CoreOS [\#21](https://github.com/voxpupuli/puppet-pxe/pull/21) ([gehel](https://github.com/gehel))
- Make it so it is possible to override baseurl [\#18](https://github.com/voxpupuli/puppet-pxe/pull/18) ([dmsimard](https://github.com/dmsimard))

## [0.1.0](https://github.com/voxpupuli/puppet-pxe/tree/0.1.0) (2014-10-19)

[Full Changelog](https://github.com/voxpupuli/puppet-pxe/compare/0.0.9...0.1.0)

**Merged pull requests:**

- Import testing from skeleton [\#17](https://github.com/voxpupuli/puppet-pxe/pull/17) ([xaque208](https://github.com/xaque208))

## [0.0.9](https://github.com/voxpupuli/puppet-pxe/tree/0.0.9) (2014-07-01)

[Full Changelog](https://github.com/voxpupuli/puppet-pxe/compare/0.0.8...0.0.9)

**Closed issues:**

- err: Failed to apply catalog: Could not find dependent  [\#7](https://github.com/voxpupuli/puppet-pxe/issues/7)

**Merged pull requests:**

- Make test manifests useful and update README [\#15](https://github.com/voxpupuli/puppet-pxe/pull/15) ([xaque208](https://github.com/xaque208))
- Defaultmenu [\#13](https://github.com/voxpupuli/puppet-pxe/pull/13) ([xaque208](https://github.com/xaque208))

## [0.0.8](https://github.com/voxpupuli/puppet-pxe/tree/0.0.8) (2014-04-25)

[Full Changelog](https://github.com/voxpupuli/puppet-pxe/compare/0.0.7...0.0.8)

**Merged pull requests:**

- Escaped all variables for style [\#12](https://github.com/voxpupuli/puppet-pxe/pull/12) ([WhatsARanjit](https://github.com/WhatsARanjit))
- Just changing a // into a / [\#11](https://github.com/voxpupuli/puppet-pxe/pull/11) ([WhatsARanjit](https://github.com/WhatsARanjit))
- Adjusting module for Rapid Deployment [\#10](https://github.com/voxpupuli/puppet-pxe/pull/10) ([WhatsARanjit](https://github.com/WhatsARanjit))
- Updated all templates to use "@variable\_name" to get rid of "deprecated" warnings [\#9](https://github.com/voxpupuli/puppet-pxe/pull/9) ([fvoges](https://github.com/fvoges))
- Make the pxe::images reosurce safer for RHEL [\#8](https://github.com/voxpupuli/puppet-pxe/pull/8) ([trlinkin](https://github.com/trlinkin))
- \(maint\) Add Travis CI testing [\#6](https://github.com/voxpupuli/puppet-pxe/pull/6) ([xaque208](https://github.com/xaque208))
- Add path to gunzip for Debian systems [\#5](https://github.com/voxpupuli/puppet-pxe/pull/5) ([diddi-](https://github.com/diddi-))

## [0.0.7](https://github.com/voxpupuli/puppet-pxe/tree/0.0.7) (2013-05-12)

[Full Changelog](https://github.com/voxpupuli/puppet-pxe/compare/0.0.6...0.0.7)

**Closed issues:**

- README does not mention dependency on tftp [\#4](https://github.com/voxpupuli/puppet-pxe/issues/4)

**Merged pull requests:**

- Remove duplicate tool dir file definition [\#3](https://github.com/voxpupuli/puppet-pxe/pull/3) ([blkperl](https://github.com/blkperl))

## [0.0.6](https://github.com/voxpupuli/puppet-pxe/tree/0.0.6) (2013-05-02)

[Full Changelog](https://github.com/voxpupuli/puppet-pxe/compare/0.0.5...0.0.6)

**Closed issues:**

- Modulefile dependencies [\#2](https://github.com/voxpupuli/puppet-pxe/issues/2)

## [0.0.5](https://github.com/voxpupuli/puppet-pxe/tree/0.0.5) (2013-04-22)

[Full Changelog](https://github.com/voxpupuli/puppet-pxe/compare/0.0.4...0.0.5)

**Closed issues:**

- Menu system needs work [\#1](https://github.com/voxpupuli/puppet-pxe/issues/1)

## [0.0.4](https://github.com/voxpupuli/puppet-pxe/tree/0.0.4) (2013-01-24)

[Full Changelog](https://github.com/voxpupuli/puppet-pxe/compare/8ca55eee55b85be6e5e500d5052ffd4324ce398d...0.0.4)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
