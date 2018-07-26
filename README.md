# StrongSwan IPsec setup guide

## Getting Started

### Prerequisites

* Ubuntu 16.04
* `curl` or `wget` should be installed

### Qucik Installation

**via curl**

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Proscend/ipsec-strongswan-setup/master/install.sh)"
```

**via wget**

```
sh -c "$(wget https://raw.githubusercontent.com/Proscend/ipsec-strongswan-setup/master/install.sh -O -)"
```

### Default Configuration

Hub-and-spoke toplogy

This guide will setup the IPsec and act as Hub role.

```
                     +-------+
                     |  Hub  |
                     +---+---+
                         |
                  +------+-----+
      +-----------+  Internet  +-----------+
      |           +------+-----+           |
      |                  |                 |
      |                  |                 |
 +----+----+        +----+----+       +----+----+
 | Spoke 1 |        | Spoke 2 |       | Spoke 3 |
 +---------+        +---------+       +---------+
192.168.1.0/24     192.168.2.0/24    192.168.3.0/24
```

| Attribute   | Hub's conn 1   | Hub's conn 2   | Hub's conn 3   |
|-------------|----------------|----------------|----------------|
| leftsubnet  | 0.0.0.0/0      | 0.0.0.0/0      | 0.0.0.0/0      |
| rightsubnet | 192.168.1.0/24 | 192.168.2.0/24 | 192.168.3.0/24 |

### Customize Configuration

The default pre-shared key is `proscend`.

You can provide the `vpn.env` file to change the pre-shared key (`VPN_PSK`).

vpn.env example:

```
VPN_PSK="password"
```

And re-run the `./start.sh` to re-configure IPsec.
