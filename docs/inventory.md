[![Build Status](https://travis-ci.org/polynimbus/polynimbus.png?branch=master)](https://travis-ci.org/polynimbus/polynimbus)

![Polynimbus logo](logo.png)


## Overview

Polynimbus is a multi-cloud infrastructure management tool.

Polynimbus Inventory and Polynimbus Panel subprojects aim specifically at working with many separate cloud environments belonging to many different organizations (which is not possible using eg. AWS Organizations). They are intended primarily for:
- IT outsourcing companies
- software houses working with multiple clients

Polynimbus Inventory is a crawler that analyzes resources (servers, databases, storage, domains, serverless objects etc.) created on all configured cloud accounts, and prepares an inventory, that can be used by eg. Polynimbus Panel.

Polynimbus Panel (provided as a [separate repository](https://github.com/polynimbus/polynimbus-panel) for security reason) provides a clean and simple web panel, showing all resources crawled by Polynimbus Inventory. Using this panel, you can avoid over 90% of switching your browser between accounts during typical DevOps/SRE work and dramatically increase your productivity.

Polynimbus supports the following cloud vendors:
- Alibaba Cloud
- Amazon Web Services
- Beyond e24cloud.com
- Google Cloud Platform
- Hetzner Cloud
- Hetzner Online (classic dedicated servers)
- Microsoft Azure
- Oracle Cloud
- Rackspace Cloud

## Polynimbus Inventory vs AWS Organizations

AWS Organizations help to scale AWS usage across multiple accounts. However all these accounts have to share billing and security aspects - thus need to belong to a single organization. This is not a case for Polynimbus.

Polynimbus was designed to support IT outsourcing business - where our employees have access to many cloud accounts, each belonging to a different organization, having different access controls, security measures, payment methods etc. And where they basically cannot be connected using AWS Organizations or any other "native" cloud service.


## Architecture and security aspects

Polynimbus Inventory and Polynimbus Panel are divided into 2 separate parts, that share a local `/var/cache/.polynimbus` directory.

Crawler part is written as a collection of shell scripts, run using crontab. It is continuously tested on Debian (currently Stretch and Buster), and Ubuntu 18.04 LTS. It also uses several PHP scripts, run with `php-cli`.

Panel part is written as PHP application, with very minimal CSS/JS using jQuery. In both parts, all PHP scripts are written to be compatible with PHP 5.2 or later. No databases are required.

### Security model

All data exchange between crawler and web panel is performed through local filesystem directory - or 2 directories to be exact:
- `~/.polynimbus/inventory` (for root, it should be symlink to `/var/cache/polynimbus/inventory`) - everything except of object storage file lists
- `~/.polynimbus/storage` (for root, it should be symlink to `/var/cache/polynimbus/storage`)

Thanks to this, web panel is completely separated from the actual account credentials, and can be run on separate hosts (assuming that these directories are shared over NFS, rsynced using `/opt/polynimbus/inventory/cron/sync-panel-data.sh` script etc.).

### Data versioning

Files written by crawler are stored in 2 locations, main directory, and date-based subdirectory, eg.:
- `~/.polynimbus/inventory/databases.list`
- `~/.polynimbus/inventory/2019/201912/20191204/databases.list`

Of course, the first one is overwritten with each new version of this file, however the second one stays forever (until manual cleanup). So you can always go back to historical versions and eg. compare particular file day-by-day to find out, when some event happened etc.

### Minimal file size requirement

All new files are first stored as eg. `~/.polynimbus/inventory/databases.list.new` and then linked to date-based subdirectory and renamed to the destination name, only if they met the minimal fize size, that is defined in particular script, eg. 10 bytes.

This simple mechanism is used to prevent accidental data losses by overwriting last good version of some file with empty one eg. as a result of network failure.

### Blacklists

Blacklists are implemented mostly for Amazon Web Services, to prevent repeatable querying for resource types, to which connected API user don't have permissions, and thus generating repeatable security warnings in AWS CloudTrail or any other security solution.

There are separate blacklists for:
##### Amazon Web Services:
- EC2 (compute instances)
- RDS (databases)
- KMS (encryption keys)
- Cognito (users database for external applications)
- Lambda (serverless functions)
- CloudTrail (security events logging)
- Route53 (DNS domains and records)
- IAM (users, groups, permissions, access keys)
- S3 (object storage)
- S3 backup (special case: don't generate Polynimbus Backup profiles for specified S3 buckets)
##### Google Cloud Platform:
- IAM (per project)
- overall API access (except getting list of available projects for particular account)

Blacklist files are named eg. `~/.polynimbus/settings/aws/list-compute.blacklist` and contain account names, one per line (except where stated otherwise).


## Installation

Polynimbus has to be installed exactly into `/opt/polynimbus` directory. You just need to execute as root:

```
git clone https://github.com/polynimbus/polynimbus /opt/polynimbus
/opt/polynimbus/inventory/install.sh
```

Note that this script will first invoke `/opt/polynimbus/install.sh` for basic configuration. Next, you can adjust crontab entries for `/opt/polynimbus/inventory/cron/*.sh` scripts in `/etc/crontab` file.

See https://github.com/polynimbus/polynimbus-panel for Polynimbus Panel installation instructions.


## Relations betwen Polynimbus subprojects

### Polynimbus API

[Polynimbus API](../docs/api.md) subproject provides consistent command line API to manage server instances during their full lifecycle, from launching and software provisioning, through normal operation, until decommissioning.

Polynimbus Inventory relies on API layer where possible. Both API and Inventory parts are delivered as a single repository.

### Polynimbus Backup

[Polynimbus Backup](../docs/backup.md) subproject is a fully automatic local backup for object storage (S3 only for now). It is provided in a separate repository, to allow installing Backup subproject on separate storage hardware, with minimal dependencies (without Polynimbus itself).

Backup relies on `/opt/polynimbus/inventory/cron/prepare-backup-configuration.sh` script from Inventory part - this script is responsible for writing configuration profiles for Amazon S3 buckets (for `s3cmd` tool), and Azure Storage Shares (using `cifs-utils` and `rsync`; Azure Storage Blobs are not supported yet). These profiles are stored respectively in `~/.polynimbus/cache/aws/s3cmd` and `~/.polynimbus/cache/azure/storage-accounts` directories - these directories should be exposed to Polynimbus Backup in any way (NFS, rsync etc. - you can optionally use `/opt/polynimbus/inventory/cron/sync-backup-configuration.sh` script for that).
