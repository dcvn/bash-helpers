# dcvn/bash-helpers

This repository contains several bash files
providing functions one can use in shell scripts.



## Installing

You can just download or clone this package, and find your own way to use it.

But if you are familiar with composer, read on.

### Using composer

  * First, you need to add it to the **repositories** section
*(as this package is not on packagist.org)*.

```json
"repositories": [
  {
    "type": "vcs",
    "url": "https://github.com/dcvn/bash-helpers",
   }
],
```
  * Then, **require** it.
*For now, there are no tags/versions. When they come, start using them.*

```json
"require": {
  "dcvn/bash-helpers" : "*"
},
```
  * Finally, add the following **scripts**. *It will generate a "sources.sh" in "vendor", inspired by the "autoload.php" for php.*
    * First command empties the shared file.
    * Second command adds a source line for this package *(more package lines could be added)*.
    * Last command removes duplicates from the shared file.

```json
"scripts": {
  "pre-autoload-dump": [
    "echo -n '' > vendor/sources.sh",
    "echo 'source vendor/dcvn/bash-helpers/lib/core.sh' >> vendor/sources.sh",
    "sort vendor/sources.sh | uniq > vendor/sources_tmp.sh; mv vendor/sources_tmp.sh vendor/sources.sh"
  ]
}
```

#### Run composer

To update to the most recent version: `composer update`.
  
## Usage in you project script

When installed by composer, at the start of your project script, you use:

```bash
source vendor/sources.sh
```
... to include the core *(and possibly the cores of other packages)*.

To use other helpers, use the `require_lib` command from our core package:

```bash
require_lib config
require_lib syslog
```
The names are the file names in `lib` without the .sh extension.

----
