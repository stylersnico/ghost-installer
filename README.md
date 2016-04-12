Build Nginx & LibreSSL
======================

##License
Script for building the latest release of Nginx with the latest release of LibreSSL
Copyleft (C) NSWeb Solutions - 2016

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
This script build the latest release of Nginx with the latest release of Libressl

- GeoIP
- IPV6
- HTTP2
- Threads AIO
- CHACHA20_POLY1305 support

##Dependencies
Build tools (included in the script)

##Designed for
Debian 8

##Installation
<code>cd /tmp && wget --no-check-certificate https://raw.githubusercontent.com/nswebsolutions/nginx-libressl/master/build.sh && chmod +x build.sh && ./build.sh</code>


##Ciphers for nginx .conf
Add this to your Nginx.conf to enable secure chippers and CHACHA20_POLY1305 support

<code>
ssl_ciphers 'ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-RSA-AES256-SHA384';</code></code>

<code>ssl_prefer_server_ciphers on;</code>
