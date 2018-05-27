## 2018-05-26 1.0.0
Modulesync updates and add a syslinux version parameter to support older
versions of syslinux.

## 2017-09-23 0.4.0
### Summary
This release contains cleanups of unused files and README updates to point
users in the right direction for new puppet syntax.

## 2017-01-30 0.3.0
### Summary
This release contains updates to testing, and supported versions.

#### Testing
 - Drop older versions of the Puppet 3.x from testing
 - Improve basic unit tests

#### Features
 - Fixes for mfsbsd image deployment

## 2016-12-29 0.2.0
### Summary
This release contains updates for testing updates and mfsbsd image
handling updates.

#### Testing
JSON gems have been pinned for ruby versions.

#### Features
Improve mfsbsd support for newer FreeBSD.


## 2016-04-22 0.1.5
### Summary
This release contains bugfixes to the handling of the template parameter on a
couple of class.

#### Bugfixes
- Fix template parameter handling to use received template in file resource for
  installentry and entry classes.
