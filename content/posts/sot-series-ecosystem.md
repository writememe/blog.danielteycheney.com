+++
title = "Source of Truth Series - Ecosystem"
date = 2022-01-06T20:38:10+11:00
tags = ["sot"]
categories = ["source-of-truth"]
draft = false
+++

# Introduction

In the [next post about Source of Truth (SoT)](https://blog.danielteycheney.com/tags/sot/), I am going to explain some of the key elements of the ecosystem, which contribute to the SoT.


## Overview

The SoT ecosystem is comprised of systems, data models, data and roles. These are listed out below:

- **SoT System** - The system which will house the SoT data.
- **SoT Data Models** - The abstract model that organises elements of SoT data and standardises how they relate to one another and to the properties of real-world entities.
- **SoT Data** - The actual data of interest, stored as defined by the data model.
- **Consumer Role** - A consumer of the SoT, namely its data.
- **SoT System Owner Role** - The designated owner of the SoT, responsible for the design and implementation of the SoT system.
- **SoT Data Owner Role** - The designated owner of the SoT data, responsible for the design and implementation of the data schema.
- **Contributor Role** - A person who contributes to the maintenance and integrity of the SoT data.

### SoT System

The SoT system can take on many forms, and as you progress through your SoT maturity journey, you may utilise some of these methods. They all have their advantages and disadvantages, but I will elaborate on a few examples below:

#### Starter/Low Maturity SoT Systems

As you start out in an environment, it's common to come across using the following lower maturity systems:

- Excel spreadsheets
- CSV files
- YAML files
- JSON files

These systems are a great starting point, and most people are used to interacting with these data formats. The advantages are that they're easy to setup and use. however validating data input, role-based access, representing relational data will become a problem.

#### Mid Maturity SoT Systems

As you progress on your SoT maturity journey, you may potentially look at mid level maturity SoT systems. These are an improvement on low maturity SoT systems, as they have the ability to enforce data types as defined in your data models.

For example, you could ensure that a field only accepts a boolean or an integer. From my research, the only mid maturity SoT systems I've encountered would be non-relational databases. A few examples are:

- MongoDB
- AWS DynamoDB
- Azure Cosmos DB

If you're able to progress from low maturity SoT systems to high maturity SoT systems, I would avoid these SoT systems altogether. They will require significant work in terms of applying your data model.

#### High Maturity SoT Systems

The ultimate goal is to end up leveraging a high maturity SoT system, which should come with some core functionality, but extensible enough to extend to your business use-cases. Some of the characteristics of a high-maturity SoT system would be:

- Feature-parity API interface
- Role-based access control
- Relational back end database, to model your complex, relational environment
- Pre-defined core data models, to save you having to invest in that undifferentiated work
- Ability to extend data models, to accommodate your business needs

In relation to network automation, the two leading solutions are:

- [netbox](https://netbox.readthedocs.io/en/stable/)
- [nautobot](https://nautobot.readthedocs.io/en/stable/)

### SoT Data Models

The SoT data model is abstract model that organises elements of SoT data and standardises how they relate to one another and to the properties of real-world entities.

To illustrate this point, we will analyse storing data about Virtual Local Area Networks (VLANs), and how a data model can help enforce greater quality data. The example is somewhat simplified, but it should serve to demonstrate the concept.

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

Using that information, we could define our model of a VLAN to start out like something in the following code snippet.

> NOTE: Whilst the data model is defined in JSON data format, keep in mind that the same model could be in any other data format, such as YAML, XML or others.


```
{
    "id": integer,
    "name": string,
    "enabled": boolean,
}
```

Observe that instead of using the words of `active` or `suspend`, a boolean value is used to define the `enabled` attribute. This is an example of abstracting the semantics into a more generic, reliable, readable model. Given there are only two feasible values, using a boolean to model this attribute allows us capture the data with the most minimal amount of complexity.

If we were to allow the modelling of `active` or `suspend` as strings, we would then need to deal with "close enough" problems like. Do we accept the following inputs?:

- Active
- SUSPEND
- suspenD

Sure, we could normalise the values below to all lower-case, but it's not giving us additional value over using a boolean. The key is then changed from the natural name of `state` to `enabled` so that it seems more logical to the consumers of the data.




### SoT Data

The SoT data is the actual data kept about the system of interest. Following on from the data model example above, we could store the data about the configuration snippet using the data model. 

NOTE: We've added a top level key called `vlans` in participation of there being more than one VLAN:

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

But, you can have SoT data, without a defined SoT data model. In fact, many people start out this way, by virtue of recording "something" in a SoT is better than not one at all. Where SoT data models are important, is that you can use those models as your business logic to prevent people storing data in an incompatible format such as shown in the examples below:


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

As mentioned above, if you are using low maturity systems, these don't come with data model validation. You would have to insert another layer into your Source of Truth to validate data input, or worse, rely on people to get it right.


## Roles

Multiple roles which interact with the SoT ecosystem which are described below.

### Consumer

The consumer role is any individual or entity which consumes data from the SoT. Their primary interaction with the system is to query or consume SoT data to make business decisions.

As such, the underlying governance, maintenance and implementation concerns are abstracted away from the interaction with the system.

A consumer role would not have the ability to alter the SoT system, data model or data and is analogous to read-only access.

### SoT System Owner

The SoT System Owner role is responsible for the overall design and implementation of the SoT system. Their primary role is to ensure that the SoT system is designed and implemented to address the appropriate requirements.

Other responsibilities would be ensuring that the system is highly available, resilient, secure and has appropriate interface methods available to interact with the system.


### SoT Data Owner

The SoT Data Owner role is responsible for managing all governance aspects related to the SoT data. 

Their primary responsibilities are to design and implement the data model. In addition to this, they're responsible for ensuring that there is governance and controls around maintaining the integrity of the SoT data.

If new SoT data storage or requirements are needed (for example recording VXLAN data), the SoT data owner would work with the relevant teams are ensure that the correct models are defined and implemented.

### Contributor

The contributor role is any individual or entity who contributes to the maintenance of SoT data. A contributor plays a pivotal role in ensuring that the "operational" aspects of the system such as SoT data accuracy is kept in good health.

In addition to this, they're most likely to discover limitations of the system, such as no suitable places for new SoT data, or missing features of the SoT system.

### Roles Summary

As you can imagine, it's common for some organisations to have an individual who fills multiple roles.

For example, a network engineer is most likely going to be both a consumer and contributor. However, a Service Desk member is most likely going to be a consumer.

It's important to understand these roles, and ensure your organisation has delegated these roles appropriately. Without a formal delegation of these roles, often a SoT ecosystem will start out with great promise, only to be bogged down in inter-company politics and start to decay.

## Conclusion

In this post, we touched on the elements which comprise the SoT ecosystem. No matter where you are on the SoT maturity curve, it's important to understand the tools, frameworks and roles which make a successful SoT.

Hopefully this post gives you something to consider, and provides some insight on what you need to consider in terms of the SoT ecosystem.

Thank you for reading.