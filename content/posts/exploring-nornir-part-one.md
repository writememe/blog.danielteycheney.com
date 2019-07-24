+++
title = "Exploring Nornir - Part One"
date = 2019-07-24T19:23:29+10:00
tags = ["technical", "nornir", "napalm"]
categories = [""]
draft = false
+++

***This post is the first in a series of posts in exploring the Nornir automation framework***

# Exploring Nornir - Part One

Over a year ago, I came across an alternative automation framework called Brigade, now renamed Nornir. At the time,
I was about to embark on learning Ansible but after having a cursory look at this framework, it had shown great promise.

Recently, I've had a chance to revisit Nornir and use it for a problem I am trying to solve.

# What is Nornir?

To quote the [official documentation](https://nornir.readthedocs.io/en/stable/tutorials/intro/overview.html):

***Nornir is an automation framework written in python to be used with python.***

This doesn't seem particularly impressive or noteworthy if you don't come from a Python background, but please read on
and I will elaborate on the benefits of this simple statement.

# How does Nornir work?

Nornir uses an [inventory](https://nornir.readthedocs.io/en/stable/tutorials/intro/inventory.html#)
and the [inheritance model](https://nornir.readthedocs.io/en/stable/tutorials/intro/inventory.html#Inheritance-model) to
store tiered information about your inventory. This functionality is akin to what Ansible offers.

From here, Nornir can [execute tasks](https://nornir.readthedocs.io/en/stable/tutorials/intro/executing_tasks.html) 
using various [plugins](https://nornir.readthedocs.io/en/stable/plugins/index.html) to carry out automation tasks as
required.

# Why use Nornir?

There are some differentiators which make Nornir a interesting use case.

## 1) It's ***fast***

Nornir allows the ability for 
[parallel task execution](https://nornir.readthedocs.io/en/stable/ref/internals/execution_model.html), 
allowing you full flexibility to execute at speed or perform
standard looping on a per-task basis.  

Whilst developing a Nornir project, I would often develop a task using a
simple loop, then reconfigure to take advantage of parallelization.

Compared to Ansible, this feature alone can save a significant amount of time.

## 2) Powerful inventory filtering

Nornir provides the ability to apply complex 
[filtering](https://nornir.readthedocs.io/en/stable/tutorials/intro/inventory.html#Filtering-the-inventory) to your
inventory, allowing you be precise yet elegant in 
classifying similar hosts to perform some tasks.

In future, I will dedicate a post to filtering in Nornir to solve some automation challenges.

## 3) Utilise existing tools and modules

Being pure python, you can leverage all your existing tools. I use [Pycharm](https://www.jetbrains.com/pycharm/)
for all other Python projects which is a great IDE for Python.

You can also use code auditing and linting tools like [Pylama](https://pylama.readthedocs.io/en/latest/#) or
[Black](https://black.readthedocs.io/en/stable/)
against your Nornir projects.

Finally, rather than scouring the Internet for obscure custom modules or writing them yourself, you can leverage the thousands
of existing Python modules to perform a task not provided by Nornir. 

## 4) Did I mention it's written in Python?

There is most likely someone in your company who has some Python knowledge who may not even be in networking or security. 
Starting a conversation about this project may help you share some common ground and break down some barriers. 

If that doesn't work, there are many great resources for Python, with a network focus. I've listed a few below:

[Python for Network Engineers](https://pynet.twb-tech.com/) - by Kirk Byers  
[Mastering Python Networking](https://www.packtpub.com/au/networking-and-servers/mastering-python-networking-second-edition) - by Eric Chou  
[Python 3 Network Programming](https://academy.gns3.com/p/python-network-programming) - by Mihai Catalin Teodosiu


In the next post, I will explore and use Nornir to solve a common challenge within most environments.





 