[![Build Status](https://travis-ci.org/polynimbus/polynimbus.png?branch=master)](https://travis-ci.org/polynimbus/polynimbus)

![Polynimbus logo](docs/logo.png)


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


## Polynimbus vs Terraform

Both Polynimbus and Terraform have similar capabilities, but completely different use cases.

Terraform follows Infrastructure as Code philosophy, which works very well for single, bigger projects, where users need infrastructure versioning, and tight control over what's happening in many layers, combined into single tool. On the other hand, it's not suitable for IT oursourcing environments:
- it is hard to use many cloud accounts at once (eg. 50 different AWS accounts for 50 different customers/projects)
- it is based on static configuration files
- syntax and semantic details of these files are different for each supported cloud vendor (so migration to other vendor/account is not easy)

Polynimbus uses totally different approach:

- the whole infrastructure management model is much more thin and dynamic - it acts as a simple resource pool, and doesn't try to cover other layers like DNS management or server/application provisioning  (it should be achieved by other elements of the whole infrastructure management stack, eg. Puppet, Chef, Ansible, Server Farmer, Salt etc.)
- it uses exactly the same syntax and semantics for all supported cloud vendors (so switching to other vendor is just a matter of changing vendor and account names, no further code changes should be required)
- it supports many cloud vendors and accounts at the same time (it is possible to actively use eg. 50 different AWS accounts and manage infrastructure for different customers/projects)

##### TL;DR:

- Terraform - to manage your own infrastructure (eg. as a corporation or startup)
- Polynimbus - to manage infrastructure for many different customers (eg. as software house, or IT oursourcing company)


## Operations reference

```
/opt/polynimbus/api/v1
|
├── all
|   ├── list-accounts.sh  # list all configured accounts for all vendors
|   ├── list-instances.sh # list all launched instances for all vendors and accounts
|   └── test.sh           # test all configured accounts, if they are still valid (eg. from crontab)
|
├── account
|   ├── list.sh           # list all configured accounts for given vendor, eg. aws
|   ├── setup.sh          # configure new account
|   └── test.sh           # test if configured account is still valid
|
├── image
|   ├── list.sh           # list available Linux image names (in vendor-specific format)
|   └── get-ubuntu.sh     # get image name of latest Ubuntu LTS version supported by given vendor
|
├── instance
|   ├── list.sh           # list created instances (also created manually)
|   ├── create.sh         # create new cloud instance
|   ├── launch.sh         # create new cloud instance and wait until it's ready
|   ├── wait.sh           # wait until newly created instance is ready
|   └── delete.sh         # delete instance
|
├── instance-type
|   ├── list.sh           # list instance types (in vendor-specific format, eg. m5.2xlarge)
|   └── get-default.sh    # get default instance type configured for given vendor/account
|
├── key
|   ├── list.sh           # list ssh keys uploaded to given vendor/account
|   ├── create.sh         # create and upload new ssh key pair
|   └── get-path.sh       # get full path for given ssh key name
|
└── region
    ├── list-available.sh # list all regions available for given vendor/account
    └── get-configured.sh # get primary region associated with given vendor/account
```


## Installation

Polynimbus has to be installed exactly into `/opt/polynimbus` directory:

```
git clone https://github.com/polynimbus/polynimbus /opt/polynimbus
/opt/polynimbus/install.sh
/opt/polynimbus/api/v1/account/setup.sh yourvendor youraccount
```

where:
- `yourvendor` is one of: `alibaba`, `aws`, `azure`, `e24`, `google`, `hetzner`, `oracle`, `rackspace` or `robot`
- `youraccount` is the name of your configured account (or region name in case of `azure`)

Once you finished the initial setup, you can always manually edit files inside `/etc/polynimbus` directory to make sure that your vendor is properly configured.

Additional notes:

1. `azure`, `google` and `oracle` vendor drivers support having only one account configured at the same time, however `azure` allows operating on each region as separate pseudo-account.

2. For `azure` and `google`, the setup process needs browser interaction.

3. For `rackspace` vendor driver, the configuration process will ask you for a Profile Name. Polynimbus works only with named profiles, not with the default nameless profile, so you have to type some non-empty name there, even if you use only one Rackspace account.

4. `alibaba` vendor driver doesn't support creating and deleting instances yet, and listing existing instances works only in full details mode.

5. `oracle` vendor driver requires manual installation of OCI client software (details [here](drivers/oracle/README.md)).

6. `robot` (Hetzner Online) is read-only.


## Example usage

### Launching new cloud instance

```
/opt/polynimbus/api/v1/instance/launch.sh aws prod_account prod_key1 m5.2xlarge
/opt/polynimbus/api/v1/instance/launch.sh azure eastus testkey2 Standard_A2
```

Hostname of the new instance will be written on console, as soon as it's ready for provisioning.

Parameters:

- vendor name
- account name
- ssh key name (key will be created if not exists yet)
- instance type (optional, vendor-specific, eg. `m5.xlarge`, `f1-micro`, `Standard_H8`)
- image name (optional, vendor-specific, eg. `18.04-LTS`, `18.04`, `ubuntu-1804-lts`, `ami-0ee06eb8d6eebcde0`)

### Listing all configured accounts

```
/opt/polynimbus/api/v1/all/list.sh
```

### Listing cloud instances for given account

```
/opt/polynimbus/api/v1/instance/list.sh aws prod_account
```


## Instance list format

`/opt/polynimbus/api/v1/instance/list.sh`, `/opt/polynimbus/api/v1/instance/create.sh`, `/opt/polynimbus/api/v1/instance/wait.sh` and `/opt/polynimbus/api/v1/instance/launch.sh` scripts return data in common format (`list.sh` returns all instances, one per line, while others only the created one):

```
hostname/ip state ssh-key-name region instance-type instance-id system-id [optional fields]
```

Examples:

```
187.68.205.35.bc.googleusercontent.com running test2018 europe-west1-c f1-micro test2018-109f ubuntu-1804-lts

static.4.3.2.1.clients.your-server.de running test2018 fsn1-dc8 cx11 hosting.yourcompany.com ubuntu-18.04
```

In fact, **all** fields are optional in some vendor drivers (`-` can be returned instead of value, if there's no way to find out the proper value).

##### Field descriptions

- `hostname/ip` - either IP address, or full hostname if possible (for newly created, or terminated instances, `-` can be returned instead)
- `state` - `running` means that instance is ready for provisioning and work
- `ssh-key-name` - name of ssh key for the instance (can be mapped into full pathname using `/opt/polynimbus/api/v1/key/get-path.sh` script, eg. `test1` to `/etc/polynimbus/ssh/id_aws_test1`)
- `region` - region, in which instance is created (vendor-specific, eg. `eu-west-1`, `europe-west1-c`, `eastus`. `fsn1-dc8`)
- `instance-type` - instance type (vendor-specific, eg. `m5.xlarge`, `f1-micro`, `Standard_H8`)
- `instance-id` - unique instance identifier, that should be passed to other scripts operating on instances (vendor-specific)
- `image-name` - Ubuntu (or other OS) version (vendor-specific, eg. `18.04-LTS`, `18.04`, `ubuntu-1804-lts`, `ami-0ee06eb8d6eebcde0`)
- `created-date` - date in format `yyyy-mm-dd`
- `tags` - list of optional instance tags, concatenated to single field (format and allowed characters are vendor-specific)
- vendor-specific optional fields, eg. VPC-id and list of security groups for AWS

##### Possible instance states

- `pending` - just created, not ready yet
- `running`
- `terminated`


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
| **Copyright:**       | Copyright 2015-2018 Tomasz Klim          |
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
