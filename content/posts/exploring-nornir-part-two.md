+++
title = "Exploring Nornir - Part Two"
date = 2019-08-02T20:07:12+10:00
tags = ["technical", "nornir", "napalm"]
categories = [""]
draft = false
+++

***This post is the second in a series of posts in exploring the Nornir automation framework.  
The first post can be
found [here](https://blog.danielteycheney.com/posts/exploring-nornir-part-one/).***  

# Exploring Nornir - Part Two

In this post, we will explore a common automation problem prevalent across every environment - ***discovery and collection of network configuration and state.***

## The problem

When interacting with a new or existing network, we need a way to retrieve configuration and state off all network devices. This data feeds into a number of activities such as:

- Network diagrams and documentation 
- Audits
- Migrations
- Designs
- Compliance reporting
- Maintenance renewals

Traditionally this process has been manual and as a result, trade-offs are made with regard to the accuracy and currency of this data. Some of these trade-offs are:

| Collection Type| Trade-off|
| ------------ |-----------|
| Manual retrieval of data |Time-intensive and error-prone|
| Partial collection of data | Incomplete data where assumptions are made to fill in the gaps |
| No collection of data | Reliance on static or stale documentation for activities |
It's evident that whilst trade-offs are common, they can cause downstream issues with negative effects. 

## Objectives

Nornir is used to solve this problem by meeting the following objectives:  

| Objective| Description|
| ------------ |-----------|
| Collect configuration and state |Collect as much configuration and state as possible, without investing in developing new tools to retrieve this information|
| Automated and scalable |Must be automated as possible and scale whether there is 5 or 500 devices.|
| Portable |Must be portable and be easy enough to use across multiple environments and be platform independent (Mac/Linux/Windows).|
| Multi-vendor support |Must support as multiple vendors and accommodate the major vendors (Cisco, Juniper, Arista)|
| Easy to use| Should be easy to use the toolkit so that others can use the tool with some basic training|

## Approach

Nornir with NAPALM is used to retrieve network configuration and state. By electing NAPALM, it allows us to leverage some benefits:

- Multi-vendor support
- Native integration with Nornir
- Structured data retrieval, particularly device state
- Large user base and active community development with project

A toolkit is provided, with two Python scripts which both utilise the same inventory. 
The idea over time would be to add Python scripts if additional functionality is needed from the toolkit. 


Before we get into the toolkit, it's important to explain what inventory will be used, how we will structure our inventory files
and how the inventory will be leveraged in the scripts.

## Inventory

To give additional context on the proceeding examples, below is the sample network inventory which is used in this post:  


| Hostname|IP Address| FQDN | Platform| Username| Password|
| ------------ |-----------|---------------|---------|---------|-------|
| dfjt-r001| 10.0.0.1 | dfjt-r001.lab.dfjt.local | ios | _admin_ | _Acme345_ |
| lab-arista-01| 10.0.0.11 | lab-arista-01.lab.dfjt.local | eos | _admin_ | _Acme123_ |
| lab-iosv-01| 10.0.0.12 | lab-iosv-01.lab.dfjt.local | ios | _admin_ | _Acme345_ |
| lab-iosv-02| 10.0.0.13 | lab-iosv-02.lab.dfjt.local | ios | _admin_ | _Acme345_ |
| lab-nxos-01| 10.0.0.14 | lab-nxos-01.lab.dfjt.local | nxos | _admin_ | _Acme123_ |
| lab-junos-01| 10.0.0.11 | lab-junos-01.lab.dfjt.local | junos | _admin_ | _Acme123_ |

### Hosts - hosts.yaml

Each host from the inventory is entered into the hosts file. You will note that there is minimal data in here, however note the group for
 each host is based on the hosts' operating system i.e ios, eos, nxos, junos.  
 
Nornirs inheritance model is used to populate data at the group level. An extension of this using the example inventory is below:

```
dfjt-r001.lab.dfjt.local
    hostname: dfjt-r001.lab.dfjt.local
    groups:
        - ios
        
lab-arista-01.lab.dfjt.local
    hostname: lab-arista-01.lab.dfjt.local
    groups:
        - eos        
        
lab-iosv-01.lab.dfjt.local
    hostname: lab-iosv-01.lab.dfjt.local
    groups:
        - ios

lab-iosv-02.lab.dfjt.local
    hostname: lab-iosv-02.lab.dfjt.local
    groups:
        - ios
        
lab-nxos-01.lab.dfjt.local
    hostname: lab-nxos-01
    groups:
        - nxos       
        
lab-junos-01.lab.dfjt.local
    hostname: lab-junos-01.lab.dfjt.local
    groups:
        - junos  
```

### Groups - groups.yaml

Each group contains a one-to-one mapping with the platform/operating system. Also, the credentials are stored in this location. 
One could move these credentials to the default.yaml file if they're all the same on each platform.  

```
ios:
    platform: ios
    username: admin
    password: Acme345

eos:
    platform: eos
    username: admin
    password: Acme123

nxos:
    platform: nxos
    username: admin
    password: Acme123
    
junos:
    platform: junos
    username: admin
    password: Acme123
```

### Default - default.yaml

Nothing is contained in this file, however this is where you can set inventory-wide defaults, and use the groups.yaml and hosts.yaml to 
override those defaults.

## Discovery Toolkit

Now that the data is populated, we can leverage this structure to execute both Python scripts. Two Python scripts are contained within the toolkit:  

| Python script| Description|
| ------------ |-----------|
| [day-one-toolkit.py](https://github.com/writememe/day-one-net-toolkit/blob/master/day-one-toolkit.py) | Configuration collection and detailed retrieval of state and storage in text/JSON files for all devices in the inventory. |
| [collection-toolkit.py](https://github.com/writememe/day-one-net-toolkit/blob/master/collection-toolkit.py) | Summarised discovery of key information and storage into an Excel workbook for all devices in the inventory.|

Both scripts leverage a simple filter to assign the devices in the inventory to a variable, which is used for the main functions in each script:
```
    ios_devices = nr.filter(platform="ios")
    junos_devices = nr.filter(platform="junos")
    eos_devices = nr.filter(platform="eos")
    nxos_devices = nr.filter(platform="nxos")
    
```
These scripts and their purpose are explained below:

### day-one-toolkit.py - Detailed discovery and config collection ###

At a high level, this script performs three primary functions:

1) **Configuration Collection** - Collects configurations for all devices in the inventory and stores them in individual .txt files.  
2) **NAPALM Getter Collection** - Collects all possible [NAPALM getters](https://napalm.readthedocs.io/en/latest/support/index.html#getters-support-matrix), based on the hosts operating system and stores those individual getter results
into individual JSON files.  
3) **Timestamped Log File** -  Maintains a timestamped log file which records the success/failure of the first two functions which can be used for auditing or
troubleshooting.  

#### Configuration Collection ####

Below is an example of the folders and files which are dynamically generated after configuration collection, including
the `configs/` folder:  

```
(venv) ➜  day-one-net-toolkit git:(master) ✗ tree configs 
configs
├── dfjt-r001.lab.dfjt.local
│   ├── candidate.txt
│   ├── running.txt
│   └── startup.txt
├── lab-arista-01.lab.dfjt.local
│   ├── candidate.txt
│   ├── running.txt
│   └── startup.txt
├── lab-iosv-01.lab.dfjt.local
│   ├── candidate.txt
│   ├── running.txt
│   └── startup.txt
├── lab-iosv-02.lab.dfjt.local
│   ├── candidate.txt
│   ├── running.txt
│   └── startup.txt
├── lab-junos-01.lab.dfjt.local
│   ├── candidate.txt
│   ├── running.txt
│   └── startup.txt
└── lab-nxos-01.lab.dfjt.local
    ├── candidate.txt
    ├── running.txt
    └── startup.txt

6 directories, 18 files

```

#### NAPALM Getter Collection ####

Below is an example of the folders which are dynamically generated after NAPALM getter collection, including
the `facts/` folder:  

```
(venv) ➜  day-one-net-toolkit git:(master) ✗ ls -l facts/ 
total 0
drwxr-xr-x  20 danielteycheney  staff  640 Jul 24 19:15 dfjt-r001.lab.dfjt.local
drwxr-xr-x  20 danielteycheney  staff  640 Jul 24 19:16 lab-arista-01.lab.dfjt.local
drwxr-xr-x  19 danielteycheney  staff  608 Jul 24 19:15 lab-iosv-01.lab.dfjt.local
drwxr-xr-x  19 danielteycheney  staff  608 Jul 24 19:15 lab-iosv-02.lab.dfjt.local
drwxr-xr-x  19 danielteycheney  staff  608 Jul 24 19:16 lab-junos-01.lab.dfjt.local
drwxr-xr-x  16 danielteycheney  staff  512 Jul 24 19:15 lab-nxos-01.lab.dfjt.local

```

If we explore one of the folders in more detail, below is a list of files generated which will vary based on operating
system for each host:  

```
(venv) ➜  day-one-net-toolkit git:(master) ✗ tree facts/dfjt-r001.lab.dfjt.local/
facts/dfjt-r001.lab.dfjt.local/
├── arp_table.json
├── bgp_neighbors.json
├── bgp_neighbors_detail.json
├── environment.json
├── facts.json
├── interfaces.json
├── interfaces_counters.json
├── interfaces_ip.json
├── ipv6_neighbors_table.json
├── lldp_neighbors.json
├── lldp_neighbors_detail.json
├── mac_address_table.json
├── ntp_peers.json
├── ntp_servers.json
├── ntp_stats.json
├── optics.json
├── snmp_information.json
└── users.json

0 directories, 18 files

```

#### Timestamped Log File ####

Finally, a log file is generated each time the Python script is generated in the `logs/` folder and is timestamped with the start date and time.

Below is an excerpt of the entries which are found in the log file, where success and failure is recorded:  

```
<Output omitted for brevity>
SUCCESS : dfjt-r001.lab.dfjt.local - lldp_neighbors
Processing Getter: lldp_neighbors_detail
SUCCESS : dfjt-r001.lab.dfjt.local - lldp_neighbors_detail
Processing Getter: mac_address_table
SUCCESS : dfjt-r001.lab.dfjt.local - mac_address_table
Processing Getter: network_instances
FAILURE : dfjt-r001.lab.dfjt.local - network_instances
Processing Getter: ntp_peers
SUCCESS : dfjt-r001.lab.dfjt.local - ntp_peers
<Output omitted for brevity>

```

Most importantly, there are counters kept throughout the toolkit and at the end of the log file, a summary
of the success and failures are reported as per an example below:

```
<Output omitted for brevity>

SUMMARY

SUCCESS COUNT : 110
FAILURE COUNT : 10
TOTAL COUNT : 120
```

This allows us to determine the high level information, without having to interpret the entire log file. If we're interested
in the failures, we can simply use a `grep` to find the failures using a command similar to below:

```
(venv) ➜  day-one-net-toolkit git:(master) ✗ grep "FAILURE : " logs/DISCOVERY-LOG-2019-08-03-12-16-12.txt
FAILURE : dfjt-r001.lab.dfjt.local - network_instances
FAILURE : lab-iosv-01.lab.dfjt.local - environment
FAILURE : lab-iosv-01.lab.dfjt.local - network_instances
FAILURE : lab-iosv-02.lab.dfjt.local - environment
FAILURE : lab-iosv-02.lab.dfjt.local - network_instances
FAILURE : lab-nxos-01.lab.dfjt.local - lldp_neighbors
FAILURE : lab-nxos-01.lab.dfjt.local - lldp_neighbors_detail
FAILURE : lab-junos-01.lab.dfjt.local - environment
FAILURE : lab-junos-01.lab.dfjt.local - mac_address_table
FAILURE : lab-junos-01.lab.dfjt.local - users

```

#### Use-case examples ####

After running this script, we've now collated configuration and state off our inventory to use for analysis. We can consume this data in numerous ways. Below are a few examples:

##### Retrieval of uptime across all devices #####

```
(venv) ➜  day-one-net-toolkit git:(master) ✗ grep "uptime" facts/*/facts.json       
facts/dfjt-r001.lab.dfjt.local/facts.json:  "uptime": 2565480,
facts/lab-arista-01.lab.dfjt.local/facts.json:  "uptime": 2564856,
facts/lab-iosv-01.lab.dfjt.local/facts.json:  "uptime": 2564820,
facts/lab-iosv-02.lab.dfjt.local/facts.json:  "uptime": 2564820,
facts/lab-junos-01.lab.dfjt.local/facts.json:  "uptime": 2564895,
facts/lab-nxos-01.lab.dfjt.local/facts.json:  "uptime": 1006074,

```

##### Check whether OSPF is present in any configurations #####

```
(venv) ➜  day-one-net-toolkit git:(master) ✗ grep 'ospf' configs/*/* 
(venv) ➜  day-one-net-toolkit git:(master) ✗ 
```

### collection-toolkit.py - Summarised discovery of key information ###

At a high level, this script performs two functions:

1) **Summarised Excel Report** - Collects key information about all devices using NAPALM getters and saves them to an Excel workbook.  
2) **Timestamped Log File** -  Maintains a timestamped log file which outputs the results of the applicable NAPALM getters to a log file.

#### Summarised Excel Report ###

Certain NAPALM getters are used to retrieve key information about all devices and save the results
to an Excel workbook at the root of the script directory. 

The following is collected across all devices and is saved to different worksheets within a workbook.

- Facts
- Interfaces
- Interfaces IP
- LLDP neighbors
- Users

It contains answers to questions such as:

-**_What local usernames are configured on all devices? Are these consistent?_**  
-**_What OS versions are we running for the same model?_**  
-**_Has IPv6 been configured on any devices?_**  
-**_What other network devices might be physically connected to these devices which we weren't previously aware of?_** 
  
Being Excel, this data is easy to format, interpret and convey to other parts of the IT team such as procurement, change management or upper management.

This function uses a Python module called [Openpyxl](https://openpyxl.readthedocs.io/en/stable/tutorial.html) perform the Excel
activities. By using Nornir which is written in Python, we can leverage the benefits of integrating existing 
Python modules into the automation workflow.


#### Timestamped Log File ####

Finally, a log file is generated each time the Python script is generated in the `logs/` folder and is timestamped with the start date and time.

This is mainly used for auditing and debugging purposes. Below is an excerpt of the entries which are found in the log file:

```
Start Processing Host - Facts: dfjt-r001.lab.dfjt.local
Vendor: Cisco
Model: C881W-A-K9
OS Version: C800 Software (C800-UNIVERSALK9-M), Version 15.2(4)M7, RELEASE SOFTWARE (fc2)
Serial Number: FTX183680V0
Uptime: 2595840
End Processing Host - Facts: dfjt-r001.lab.dfjt.local
```

## Conclusion ##

In conclusion, we've used Nornir to solve a common problem across all environments and have provided two ways
of representing this data. Both the toolkit and the inventory structure is homogeneous enough to cater for all environments and output folders and files are
dynamically generated without intervention from the operator.

We've also integrated a Python module not present in Nornir to provide additional functionality
without the need to write our own custom module, highlighting the power and potential of using this automation framework.

The repository for this project can be found [here](https://github.com/writememe/day-one-net-toolkit) and I hope you found this useful!










