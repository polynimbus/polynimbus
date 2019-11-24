[![Build Status](https://travis-ci.org/polynimbus/polynimbus.png?branch=master)](https://travis-ci.org/polynimbus/polynimbus)

![Polynimbus logo](docs/logo.png)

## Overview

Polynimbus is a multi-cloud infrastructure management tool, designed to increase work efficiency with many separate cloud environments. It is divided into 3 subprojects:

 1. [**Polynimbus API**](docs/api.md) - provides consistent command line API to manage server instances during their full lifecycle, from launching and software provisioning, through normal operation, until decommissioning.
 2. [**Polynimbus Inventory**](docs/inventory.md) - provided clean and simple web panel, showing all servers, databases, object storage, domains, serverless objects etc., created across all accounts. Using this panel, you can avoid over 90% of switching your browser between accounts and dramatically increase your productivity.
 3. [**Polynimbus Backup**](docs/backup.md) - fully automatic local backup for object storage. Provided in a separate repository, to allow installing Backup subproject on separate storage hardware, with minimal dependencies.

Polynimbus supports the following cloud platforms:
- Alibaba Cloud
- Amazon Web Services
- Beyond e24cloud.com
- Google Cloud Platform
- Hetzner Cloud
- Hetzner Online (classic dedicated servers)
- Microsoft Azure
- Oracle Cloud
- Rackspace Cloud

## Why Polynimbus?

Polynimbus API hides all semantic differences between all supported cloud platforms, so you can eg. create your own server deployment scheme, and then easily move your infrastructure betweens many platforms, accounts, pricing plans etc. to reduce your cloud bills.

Included web panel allows you to work efficiently with many cloud accounts, belonging to many different organizations (which is not possible using eg. AWS Organizations). You no longer need to log in to another cloud account each time you want just to check eg. configuration details of some server, or if particular database, storage bucket, Lambda function etc. is already created or not. 

## Installation

Polynimbus has to be installed exactly into `/opt/polynimbus` directory. Basic installation is just:
```
git clone https://github.com/polynimbus/polynimbus /opt/polynimbus
/opt/polynimbus/install.sh
```
This script will guide you through installation of required software dependencies. See [API documentation](docs/api.md) for usage examples.

## How to contribute

We are welcome to contributions of any kind: bug fixes, added code comments,
support for new operating system versions, cloud platforms etc.

If you want to contribute:
- fork this repository and clone it to your machine
- create a feature branch and do the change inside it
- push your feature branch to github and create a pull request

## License

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Tomasz Klim (<opensource@tomaszklim.pl>) |
| **Copyright:**       | Copyright 2015-2019 Tomasz Klim          |
| **License:**         | MIT                                      |

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
