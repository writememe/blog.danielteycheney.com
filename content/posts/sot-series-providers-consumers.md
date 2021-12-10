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

As you start out in an environment, it's common to come across the following lower maturity systems:

- Excel spreadsheets
- CSV files
- YAML files
- JSON files

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

The SoT data model is abstract model that organizes elements of SoT data and standardizes how they relate to one another and to the properties of real-world entities.

Let's take a common

