Ghost Installer for Debian 8
============================

##License
Script for installing the latest release of Ghost and the latest release of Node.JS
Copyleft (C) Nicolas Simond - 2016

This script is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This script is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this script.  If not, see <http://www.gnu.org/licenses/gpl.txt>

##About this script
This script install the latest release of Ghost and the latest release of Node.JS on a Debian 8 server.

- Ghost
- Node.js
- NPM
- Grunt
- PM2

##Dependencies
Included in the script

##Designed for
Debian 8

##Installation
<code>cd /tmp && wget --no-check-certificate https://raw.githubusercontent.com/stylersnico/ghost-installer/master/gh_installer.sh && chmod +x ./gh_installer.sh && ./gh_installer.sh</code>

##Open Ghost to internet
If you don't want to use a nginx reverse proxy, edit the following file: <code>/var/www/ghost/config.js</code>

In the "Production" section, change the following:

<code>host: '127.0.0.1',</code>

to

<code>host: '0.0.0.0',</code>

And launch this command as ghost user:

<code>pm2 stop 0 && pm2 start 0</code>

