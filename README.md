Polynimbus is a multi-cloud infrastructure management tool. It allows full lifecycle, fully automatic management of Linux-based cloud instances, using the same syntax and semantics, supporting all important cloud computing vendors:

- Alibaba Cloud
- Amazon Web Services
- Beyond e24cloud.com
- Google Cloud Platform
- Hetzner Cloud
- Microsoft Azure
- Oracle Cloud
- Rackspace Cloud

All supported vendors are well tested with Ubuntu 14.04 LTS, 16.04 LTS and 18.04 LTS, and also are expected to work without major problems with any recent Debian or Ubuntu version).


## Why Polynimbus?

Polynimbus hides all semantic differences between all supported cloud platforms and provides you a simple, clean and consistent API to deploy and manage Linux cloud instances.


## Operations reference

```
/opt/polynimbus/api/v1
|
├── all
|   └── list.sh           # list all configured accounts for all vendors
|
├── account
|   ├── list.sh           # list all configured accounts for given vendor, eg. aws
|   ├── setup.sh          # configure new account
|   └── test.sh           # test if configured account is still valid (eg. from crontab)
|
├── image
|   ├── list.sh           # list available Linux image names (in vendor-specific format)
|   └── get-ubuntu.sh     # get image name of latest Ubuntu LTS version supported by given vendor
|
├── instance
|   ├── list.sh           # list created instances (also created manually)
|   ├── create.sh         # create new cloud instance
|   ├── delete.sh         # delete instance
|   └── provision.sh      # configure new instance (works also with all other servers)
|
├── instance-type
|   └── list.sh           # list instance types (in vendor-specific format, eg. m5.2xlarge)
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
- `yourvendor` is one of: `alibaba`, `aws`, `azure`, `e24`, `google`, `hetzner`, `oracle` or `rackspace`
- `youraccount` is the name of your configured account (or region name in case of `azure`)

Once you finished the initial setup, you can always manually edit files inside `/etc/polynimbus` directory to make sure that your vendor is properly configured.

Additional notes:

1. `azure`, `google` and `oracle` vendor drivers support having only one account configured at the same time, however `azure` allows operating on each region as separate pseudo-account.

2. For `azure` and `google`, the setup process needs browser interaction.

3. For `rackspace` vendor driver, the configuration process will ask you for a Profile Name. Polynimbus works only with named profiles, not with the default nameless profile, so you have to type some non-empty name there, even if you use only one Rackspace account.

4. `alibaba` vendor driver doesn't support creating and deleting instances yet, and listing existing instances works only in full details mode.

5. `oracle` vendor driver requires manual installation of OCI client software (details [here](drivers/oracle/README.md)).


## Example usage

### Creating new cloud instance

```
/opt/polynimbus/api/v1/instance/create.sh aws prod_account prod_key1 m5.2xlarge
/opt/polynimbus/api/v1/instance/create.sh azure eastus testkey2 Standard_A2
```

Hostname of the new instance will be written on console, as soon as it's ready for provisioning.

### Listing all configured accounts and cloud instances

```
/opt/polynimbus/api/v1/all/list.sh
```

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
