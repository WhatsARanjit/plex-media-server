# Plex Media Server  Module
[![Build Status](https://app.travis-ci.com/jaysphoto/plex-media-server.svg?branch=master)](https://app.travis-ci.com/jaysphoto/plex-media-server)

## Overview

This will setup and install Plex Media server.

## Capabilities

Installalation includes:

- Plex Media Server

Requires:

- *nix operating system

## Plex Media Server Parameters
See Plex documentation for variable definitions.

* `plex_install_latest`<br />
  Default: false
* `plex_user`<br />
  Default: plex
* `plex_media_server_home`<br />
  Default: /usr/lib/plexmediaserver
* `plex_media_server_application_support_dir`<br />
  Default: \`getent passwd $plex_user|awk -F : '{print $6}'`/Library/Application Support
* `plex_media_server_max_plugin_procs`<br />
  Default: 6
* `plex_media_server_max_stack_size`<br />
  Default: 10000
* `plex_media_server_max_lock_mem`<br />
  Default: 3000
* `plex_media_server_max_open_files`<br />
  Default: 4096
* `plex_media_server_tmpdir`<br />
  Default: /tmp

## Example Usage

Install plexmediaserver:

```puppet
include plexmediaserver
```

Install latest plexmedia server with custom parameters:

```puppet
class { 'plexmediaserver':
  plex_install_latest                       => true,
  plex_user                                 => 'foo',
  plex_media_server_home                    => '/usr/share/lib/plexmediaserver',
  plex_media_server_application_support_dir => "`getent passwd $PLEX_USER|awk -F : '{print $6}'`/My Documents/Application Support",
  plex_media_server_max_plugin_procs        => '7',
  plex_media_server_max_stack_size          => '20000',
  plex_media_server_max_lock_mem            => '4000',
  plex_media_server_max_open_files          => '1024',
  plex_media_server_tmpdir                  => '/var/tmp',
}
```
