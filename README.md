# dropbox

#### Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with dropbox](#setup)
    * [What dropbox affects](#what-dropbox-affects)
    * [Beginning with dropbox](#beginning-with-dropbox)
3. [Limitations - OS compatibility, etc.](#limitations)

## Overview

This is a simple Puppet module for installing the linux dropbox client.

## Setup

### What dropbox affects

* Adds dropbox linux software repo.
* Installs dropbox package.

### Beginning with dropbox

```puppet
include '::dropbox'
```

## Limitations

This module has been built on and tested against Puppet 3.x.

This module has been tested on:

* Ubuntu 16.04
