[![Build Status](https://travis-ci.org/polynimbus/polynimbus.png?branch=master)](https://travis-ci.org/polynimbus/polynimbus)

![Polynimbus logo](logo.png)


## Overview

Polynimbus is a multi-cloud infrastructure management tool. It allows full lifecycle, fully automatic management of Linux-based cloud instances, using the same syntax and semantics, supporting all important cloud computing vendors:

- Alibaba Cloud
- Amazon Web Services
- Beyond e24cloud.com
- Google Cloud Platform
- Hetzner Cloud
- Hetzner Online (classic dedicated servers)
- Microsoft Azure
- Oracle Cloud
- Rackspace Cloud

All supported vendors are well tested with Ubuntu 14.04 LTS, 16.04 LTS and 18.04 LTS, and also are expected to work without major problems with any recent Debian or Ubuntu version).


## Why Polynimbus?

Polynimbus hides all semantic differences between all supported cloud platforms and provides you a simple, clean and consistent API to deploy and manage Linux cloud instances.






## Installation

Polynimbus has to be installed exactly into `/opt/polynimbus` directory. You just need to execute as root:

```
git clone https://github.com/polynimbus/polynimbus /opt/polynimbus
/opt/polynimbus/inventory/install.sh
```

Note that this script will also invoke `/opt/polynimbus/install.sh`.



### Example apache2 vhost configuration

```
<VirtualHost *:80>
    ServerName polynimbus.yournet.internal
    ServerSignature Off
    DocumentRoot /opt/polynimbus/inventory/web
    <Directory /opt/polynimbus/inventory/web>
        Options FollowSymLinks
        AllowOverride All
        Order allow,deny
        Allow from all
        AuthType Basic
        AuthName "Restricted zone"
        AuthUserFile /etc/apache2/.htpasswd-polynimbus
        Require valid-user
    </Directory>
</VirtualHost>
```
