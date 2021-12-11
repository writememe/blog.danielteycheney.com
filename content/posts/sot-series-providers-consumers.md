+++
title = "Source of Truth Series - Ecosystem"
date = 2021-12-10T20:38:10+11:00
tags = ["sot"]
categories = ["source-of-truth"]
draft = false
+++

# Introduction

In the [next post about Source of Truth (SoT)](https://blog.danielteycheney.com/tags/sot/), I am going to explain some of the key elements of the ecosystem, which contribute to the SoT.


## Overview

- SoT System - The system which will house the SoT data
- SoT Data Models - The abstract model that organizes elements of SoT data and standardizes how they relate to one another and to the properties of real-world entities
- SoT Data - The actual data of interest, stored as defined by the data model

Personas

- Consumer - A consumer of the SoT, namely its data
- SoT System Owner - The designated owner of the SoT, responsible for the design and implementation of the SoT system
- SoT Data Owner - The designated owner of the SoT data, responsible for the design and implementation of the data schema
- Contributor - A person who contributes to the maintenance and integrity of the SoT data

### SoT System

The SoT system can take on many forms, and as you progress through your SoT maturity journey, you may utilise some of these methods. They all have their advantages and disadvantages, but I will eloborate on a few examples below:

#### Starter/Low Maturity SoT Systems

As you start out in an environment, it's common to come across using the following lower maturity systems:

- Excel spreadsheets
- CSV files
- YAML files
- JSON files

These systems are a great starting point, and most people are used to interacting with these data formats. The advantages are that they are easy to setup and use. however validating data input, role-based access, representing relational data will become a problem.

#### Mid Maturity SoT Systems

As you progress on your SoT maturity journey, you may potentially look at mid level maturity SoT systems. These are an improvement on low maturity SoT systems, as they have the ability to enforce data types as defined in your data models.

For example, you could ensure that a field only accepts a boolean or an integer. From my research, the only mid maturity SoT systems I've encountered would be non-relational databases. A few examples are:

- MongoDB
- AWS DyanmoDB
- Azure Cosmos DB

If you're able to progress from low maturity SoT systems to high maturity SoT systems, I would avoid these SoT systems altogether. They will require significant work in terms of applying your data model.

### High Maturity SoT Systems

The ultimate goal is to end up leveraging a high maturity SoT system, which should come with some core functionality, but extensible enough to extend to your business use-cases. Some of the characteristics of a high-maturity SoT system would be:

- Feature-parity API interface
- Role-based access control
- Relational backend database, to model your complex, relational environment
- Pre-defined core data models, to save you having to invest in that undifferentiated work
- Ability to extend data models, to accommodate your business needs

In relation to network automation, the two leading solutions are:

- netbox
- nautobot

### SoT Data Models

The SoT data model is abstract model that organises elements of SoT data and standardises how they relate to one another and to the properties of real-world entities. To illustrate this point, we will analyse storing data about Virtual Local Area Networks (VLANs), and how a data model can help enforce greater quality data. The example is somewhat simplified, but it should serve to demonstrate the concept.

Firstly, let's introduce a configuration snippet from an Arista EOS device:

```console
vlan 3000
   name LEVEL_10_PRODUCTION
   state suspend
```

If we take our knowledge about VLANs, we can classify the attributes of a VLAN, by making the following statements:

- All VLAN IDs are a unique number and is mandatory to constitute a valid VLAN.
- A VLAN name is desirable, but not mandatory. 
- The operational state of a VLAN can either be active (enabled) or suspend (disabled).

Using that information, we could define our model of a VLAN to start out like something below. Observe that instead of using the words of `active` or `suspend`, a boolean value is used to define the `enabled` attribute. This is an example of abstracting the semantics into a more generic, reliable, readable model. Given there are only two feasible values, using a boolean to model this attribute allows us capture the data with the most minimal amount of complexity.

If we were to allow the modelling of `active` or `suspend` as strings, we would then need to deal with "close enough" problems like. Do we accept the following inputs?:

- Active
- SUSPEND
- suspenD

Sure, we could normalise the values below to all lower-case, but it's not giving us additional value over using a boolean. The key is then changed from the natural name of `state` to `enabled` so that it seems more logical to the consumers of the data.


> NOTE: Whilst the data model is defined in JSON data format, keep in mind that the same model could be in any other data format, such as YAML, XML or others.


```
{
    "id": integer,
    "name": string,
    "enabled": boolean,
}
```

### SoT Data

The SoT data is the actual data kept about the system of interest. Following on from the data model example above, we could store the data about the configuration snippet using the data model. NOTE: We have added a top level key called `vlans` in participation of there being more than one VLAN:

```console
{
    "vlans": [
        {
            "id": 400,
            "name": "LEVEL_10_PRODUCTION",
            "enabled": true
        }
    ]
}
```

But, you can have SoT data, without a defined SoT data model. In fact, many people start out this way, by virtue of recording "something" in a SoT is better than not one at all. Where SoT data models are important, are that you can used this models as your business logic to prevent people storing data in an incompatible format such as:


```console
{
    "vlans": [
        {
            "id": "401",  // An integer attempted to be stored as a string
            "name": "LEVEL_11_PRODUCTION",
            "enabled": true
        },
        {
            "id": 402, 
            "name": "LEVEL_12_PRODUCTION",
            "enabled": "yes" // Using a string of 'yes' to represent the True boolean
        },
        
    ]
}
```

As mentioned above, if you are using low maturity systems, these do not come with data model validation. You would have to insert another layer into your Source of Truth to validate data input, or worse, rely on people to get it right.
