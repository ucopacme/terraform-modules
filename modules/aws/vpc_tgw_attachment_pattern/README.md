#VPC cidr allocation and subnetting

## CIDR allocation for VPC

Here's a simple vpc model we could use: 

#Large /19
```
ipcalc 10.100.0.0/19

Address:   10.100.0.0           00001010.01100100.000 00000.00000000
Netmask:   255.255.224.0 = 19   11111111.11111111.111 00000.00000000
Wildcard:  0.0.31.255           00000000.00000000.000 11111.11111111
=>
Network:   10.100.0.0/19        00001010.01100100.000 00000.00000000
HostMin:   10.100.0.1           00001010.01100100.000 00000.00000001
HostMax:   10.100.31.254        00001010.01100100.000 11111.11111110
Broadcast: 10.100.31.255        00001010.01100100.000 11111.11111111
Hosts/Net: 8190                  Class A, Private Internet
```

```
ipcalc 10.100.0.0/21

Address:   10.100.0.0           00001010.01100100.00000 000.00000000
Netmask:   255.255.248.0 = 21   11111111.11111111.11111 000.00000000
Wildcard:  0.0.7.255            00000000.00000000.00000 111.11111111
=>
Network:   10.100.0.0/21        00001010.01100100.00000 000.00000000
HostMin:   10.100.0.1           00001010.01100100.00000 000.00000001
HostMax:   10.100.7.254         00001010.01100100.00000 111.11111110
Broadcast: 10.100.7.255         00001010.01100100.00000 111.11111111
Hosts/Net: 2046                  Class A, Private Internet
```

```
ipcalc 10.100.0.0/23

Address:   10.100.0.0           00001010.01100100.0000000 0.00000000
Netmask:   255.255.254.0 = 23   11111111.11111111.1111111 0.00000000
Wildcard:  0.0.1.255            00000000.00000000.0000000 1.11111111
=>
Network:   10.100.0.0/23        00001010.01100100.0000000 0.00000000
HostMin:   10.100.0.1           00001010.01100100.0000000 0.00000001
HostMax:   10.100.1.254         00001010.01100100.0000000 1.11111110
Broadcast: 10.100.1.255         00001010.01100100.0000000 1.11111111
Hosts/Net: 510                   Class A, Private Internet
```

## CIDR allocation for subnets
Our default region is us-west-2 which currently has 4 availability zones (AZs)
This seems adequate to support the SLAs of any of the applications we currently
support. Let's assume we'll want to be able to span all 4 AZs depending on an
applications requirements. We will divide each vpc into 5 zones by dividing VPCs
into 8 partitions (eac 3 bits less than the VPC CIDR) to be allocated to
network environments.

* public zone (partition 0)
* tgw zone (partition 1)
* private zone (partitions 2-3)
* data zone (partitions 4-5)
* reserved for future use (partitions 6-7)

### Large /19 VPCS

VPC 10.100.0.0/19 -  10.100.0.0-10.100.31.255
PUBLIC  10.100.0.0/22, AZs /24 CIDR, 251 ips per AZ
TGW  10.100.4.0/22, AZs /24 CIDR, 251 ips per AZ
PRIVATE  10.100.8.0/21, AZs /23 CIDR, 507 ips per AZ
DATA  10.100.16.0/21, AZs /23 CIDR, 507 ips per AZ
RESERVED  10.100.24.0/21

### Medium /21 VPCS

VPC 10.100.0.0/21 -  10.100.0.0-10.100.7.255
PUBLIC  10.100.0.0/24, AZs /26 CIDR, 59 ips per AZ
TGW  10.100.1.0/24, AZs /26 CIDR, 59 ips per AZ
PRIVATE  10.100.2.0/23, AZs /25 CIDR, 123 ips per AZ
DATA  10.100.4.0/23, AZs /25 CIDR, 123 ips per AZ
RESERVED  10.100.6.0/23

### Small /23 VPCS

VPC 10.100.0.0/23 -  10.100.0.0-10.100.1.255
PUBLIC  10.100.0.0/26, AZs /28 CIDR, 11 ips per AZ
TGW  10.100.0.64/26, AZs /28 CIDR, 11 ips per AZ
PRIVATE  10.100.0.128/25, AZs /27 CIDR, 27 ips per AZ
DATA  10.100.1.0/25, AZs /27 CIDR, 27 ips per AZ
RESERVED  10.100.1.128/25
