+++
title = "Starting Your Network Automation Journey"
date = 2020-06-15T19:14:57+10:00
tags = ["technical"]
categories = ["automation"]
draft = false
+++
 
**Disclaimer: This post was written in June 2020 and is my thoughts on this subject at this time. Circumstances and my experience will have changed months from now so please keep this in mind.**
 
In the past year or two, it's been evident that more network professionals are interested in network automation. With official certifications and
 significant investments from vendors in network automation, there has never been a better time to get started.  
 
Whenever I come across someone who is starting out, I can empathise with the sheer amount of resources now available, conflicting advice and the overwhelming feeling of where to start. 
 
In this post, I'll share some resources that I recommend, coupled with my experiences so far.
 
# Start with one programming language or domain specific language (DSL) and learn it well
 
It can be tempting to react to the latest hyped DSL, or using Go/Rust for network automation when someone posts about this on social media or Slack. You may feel
anxious that you are being left behind and that your efforts into learning Python or Ansible is a waste of time.  
 
What'sn't usually mentioned is that those people who most likely learned a language or a DSL and hit limitations pertinent to them. To know why one would change from Python to Go, you need to have a valid use case or business conditions to do so. Some examples of these may be:  
 
- Scaling and performance
- Team composition and having access to highly skilled software engineers
- Strategic imperatives, such as Go must be used for all programming as mandated by company X
 
Learning one programming language or DSL and learning it well is still a valid investment of time. Some of the skills you will learn irrespective of your
chosen language/DSL are:
 
- Data models
- Data translation
- Continuous integration
- Computational thinking
- Programming logic
 
These skills are transferable across the majority of languages and DSLs so starting with one allows you to make informed decisions when comparing others.
 
# Which programming language/DSL should I learn?
 
It depends! 

Seriously though, there are some options which have lower barriers to entry over others. As a general rule, I would choose a programming language/DSL in this order:
 
## 1) Whatever your current team is using
 
First off, I would always recommend learning whatever your current team is using. This is the least steep learning curve and most likely going to be the most successful one.  

Some immediate benefits of learning what your current team is using:
 
- You will have access to people who can provide mentoring, learning or advice in real-time. If you've ever learned anything difficult, this can't be understated.
- These people are mutually invested in your success. If you can become proficient, it will make their job easier so they can move onto more advanced problems.
- The code/solution has an immediate translation to your current world. Whatever is in place is solving a problem within the current context of your environment so this makes it easier to grasp the theory and concepts of what you are learning.
- Peer review of your work is contextually relevant, so as a result the feedback you receive is targeted and applicable.
 
Ultimately, anything is easier to learn with help from your peers and is the path of least resistance.
 
## 2) Python
 
If there isn't any network automation in place, I would recommend starting out with Python.  

Whilst the learning curve is steeper than Ansible, there are reasons that I would start out with Python:
 
- It has the broadest support within the network automation community, both in terms of people using it and vendors providing support for it.
- Hundreds of resources (videos, reference code, tutorials, books, Slack channels) exist which have been produced and available, specially to network automation. 
- Thousands of general purpose modules are available to address functionality that you may need. This means less time for you developing functionality and more time consuming these modules and producing solutions.  
- Numerous excellent open source network projects are written in Python, such as [Netbox](https://netbox.readthedocs.io/en/stable/), [NAPALM](https://napalm.readthedocs.io/en/latest/) and [Nornir](https://nornir.readthedocs.io/en/latest/) to name a few.
- Ansible, the comparatively easier option, has most modules written in Python. If you learn Python first, Ansible will be inherently easier to learn later on.
 
 
In certain quarters, the criticism of Python is that it's slow compared comparatively to other languages. Whilst this may or may not be true, remember, you are starting out as a beginner. Speed may become an issue for you at some stage of your network automation journey, but this needs to be weighed against the access to applicable resources to accelerate your learning.
 
Most other languages have limited resources, modules, community/vendor support so as a result, there will be a significant amount of time being spent working things out on your own. This will inevitably lead to frustration and potentially abandonment of your network automation journey.
 
 
## 3) Ansible
 
Some of you might be too intimidated to use Python, or may not have the time or resources to learn a programming language. Ansible is a domain-specific language so comparatively speaking to Python, it's easier to learn.  

Below are some of the reasons for learning Ansible:
 
- Good support for a large percentage of vendors, at varying levels of functionality provided. It's likely that you can solve a large percentage of common network automation problems.
- Some of the complexity or common tasks which are present within a programming language are handled by Ansible, allowing you to write less code to achieve the same outcome. Examples of these may be creating files/directories, reporting successes/failures of tasks to the operator.
- Ansible has emerged as a one of the leaders in the market as a framework for network automation. It's anticipated that they will hold this mantle for sometime yet so learning Ansible is a valid investment of your time.
 
# Why don't you recommend Terraform?
 
Personally, my experience is that Terraform is a fantastic product and solves some issues in an elegant and unique way.  

The difference is that Terraform simply doesn't have the breadth of network vendor support, network-specific resources and community adoption yet. It would be a steep learning curve to start out in Terraform considering all those factors.  

That being said, it should be on the list of things to learn after starting out with one of the above.
 
# Resources for starting out
 
Below are some resources which I recommend to get you started:
 
- [NRE Labs](https://nrelabs.io/) - Short, simple, browser-based examples covering fundamentals and examples. I'd recommend not moving onto any others until you've done all the lessons offered. Also, it's free and doesn't require you to give any of your personal data.
- [Awesome Network Automation List](https://github.com/networktocode/awesome-network-automation) - This page is maintained by the team at Network to Code and has links to numerous resources and anything you could think of related to network automation. 
- [Network to Code - Slack](https://networktocode.slack.com/) - A Slack workspace for the network automation community, hosted by Network to Code. Numerous channels and hundreds of people are available on this workspace contributing and helping others.
- [Python for Network Engineers - Free Course](https://pynet.twb-tech.com/email-signup.html) - This course from Kirk Byers offers free training on Python, using specific examples relevant to Python. Kirk is the maintainer of [Netmiko](https://netmiko.readthedocs.io/en/latest/) and is a core contributor on many open source network modules.
- [Mastering Python Networking - Third Edition](https://www.packtpub.com/au/cloud-networking/mastering-python-networking-third-edition) - This book from Eric Chou covers numerous topics including, but not limited to, Python, Ansible, Cloud Networking, APIs, Continuous Integration, Unit Testing. If you asked me to choose one book to get you up and running, this is it.
- [Building Network Automation Solutions](https://www.ipspace.net/Building_Network_Automation_Solutions) - This course is the most comprehensive offering out of the resources listed here. It covers all aspects of network automation and is continually refreshed. After finishing this course, you will have skills which will last you a lifetime. I've written a review of the course [here](https://blog.danielteycheney.com/posts/building-network-automation-solutions-review/)  
 

 
Hopefully this post is helpful in starting your network automation journey.  

Thanks for reading, and if you'd like to discuss, feel free to contact me on [Twitter](https://twitter.com/danielteycheney) or [LinkedIn](https://www.linkedin.com/in/danielfjteycheney/)
 
 
 

