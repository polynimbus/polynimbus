### OCI client setup

Unlike for other vendor drivers, OCI client setup is tricky and done wrongly, can lead to breaking your global Python installation. Because of that it needs to be done manually.

The following commands are just the examples:

```
apt-get install libssl-dev libffi-dev
apt-get purge python-cryptography* python-enum34* python-keyring* python-secretstorage* python-cffi-backend python-dbus python-idna python-ipaddress python-pyasn1 python-six python-crypto python-gi
pip install --upgrade --ignore-installed cffi
pip install --upgrade cryptography
pip install enum
pip install oci-cli
```

This also requires Debian 9.x or higher, or Ubuntu 16.04 LTS or higher.

Note: on Debian 8.x, your Python installation may break if you do this. In such case, remove the directory `/usr/local/lib/python2.7/dist-packages/cryptography` - this will fix Python, but OCI client still won't work.


### Oracle Cloud account setup

1. Create a new account. Choose US/Ashburn as your default region (below links rely on it).

2. Use `/opt/polynimbus/drivers/oracle/setup-account.sh` script to configure OCI client.

3. Go to https://console.us-ashburn-1.oraclecloud.com/a/identity/users page, choose your user, click Add Public Key button and paste the public key printed by the above script.

4. Initially your account has the only one active region - go to https://console.us-ashburn-1.oraclecloud.com/a/tenancy/regions page and enable all other regions by clicking Subscribe To This Region buttons on the list below.

5. Launch the new instance in each region that you want to use, using web console, eg. from https://console.us-ashburn-1.oraclecloud.com/a/compute/instances page, choosing:

- first listed availability domain
- Oracle-Provided OS Image with Canonical Ubuntu (any version) as boot volume
- default Virtual Cloud Network
- public subnet (suggested as default)
- enabled Assign public IP address

You can then terminate this instance (unless you want to use it). Creating it was required to setup all network-related details - now OCI client can use the existing Subnet ID.
