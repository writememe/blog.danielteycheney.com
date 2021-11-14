+++
title = "Source of Truth Series - Business Value"
date = 2021-11-13T18:31:42+11:00
tags = ["sot"]
categories = ["source-of-truth"]
draft = false
+++

# Introduction

In this post, I am going to explain the role of a Source of Truth (SoT), in context of business operations and how it's presence can provide demonstrative value to any business setting.

## Problems and Solutions

At a fundamental level, all businesses exist by providing solutions to customer problems. We are employed to add some form of value which should directly or indirectly solve customer problems. If we break down our value to the business further, we fall into one of the following categories:

- *Core Business* - Where our team or department is main is the main source of a companies profits or success. For example, a landscaper at a landscaping services company
- *Non Core Business* - Where our team or department provides a supporting role to the core business operation. It's sometimes is named "support services" or "shared services". For example, a cloud engineer at an agricultural company.

The vast majority of IT roles are non core business, so it can be difficult to demonstrate the business value of activities we undertake. Therefore, often we can be on the backfoot and perceived as an "overhead" or an "expense" and justifying large, multi department undertakings is met with resistance.

When considering the role of a SoT within your environment, it's important to show the correlation between this non-core business activity and the direct success of the core business. 

## Data drives all business

As we begin to adopt more automation into modern businesses, we begin to realise that data is the enabler (or blocker) of a companies success. With globalisation, increased competition and evolving markets, having high-integrity data is often the difference. Important business decisions are more time sensitive, complex and nuanced. The most successful business thrive by valuing data, and harnessing it's value to make more correct decisions than not.

A SoT is one method of governing and managing your business data, so that you can operate and strategise from solid foundations.

## How does a SoT and data provide business value?

In the diagram below, we are representing the basic relationship between the customer, the business and solving their problem:

![Business Question](/images/img/SoT-Concepts-Overview.png)

Going through this diagram from top to bottom, the components are described below:


#### Customer Question/Problem

The customer will have a problem, or a question that they have come to your business about. I will use these interchange these terms throughout the rest of this post as they mean the same thing in the context of this post. This is where one would receipt the problem, ask any qualification questions or clarify what would be deemed successful for the customer. These problems or questions are rarely technical, and are often so abstract from the work needed to provide a solution. 

For example, _I'd like to buy a used European electric car today, do you have any which you can show me?_

#### Business Question

After we have documented and clarified the customers' question, we now need to translate their non-technical question into one or more business questions. These are the inception of possible solutions to the customers original problem. Whilst they are now in a technical state, they still don't provide us with a level of detail to ask distinct questions or queries of our data to devise a proper solution. 


Expanding on the example above, we may have two business questions:

- _Do we have any used European electric cars in our possession?_
- _If so, are they ready for sale?_


#### SoT Query

Whilst there are often other things we need to do to solve a customers problem, we are going to scope this example to needed some sort of business data to make a decision or offer a solution. In this phrase, we break down the business question into a smaller queries which we make of a SoT to find low level detail about our business data. These example queries could be:

- Query One: Find all European used cars which are electric
- Query Two: Find all cars which match Query One, and have the status of READY FOR SALE

#### SoT

The SoT will be a direct representation of the business data, about aspects of their business. Continuing on with the example, you may have a spreadsheet of car inventory. Each entry may contain some data about each car such as:

- Make
- Model
- Year Manufactured
- Fuel Type
- Status

At the end of retrieving your query results from the SoT, the SoT query results are rolled up into the business questions, then the business question results are interpreted and an answer/solution is given to the customer. We will now go through an example below of and demonstrate the business value of a SoT.

## Example Scenario

In this scenario, the customer is a patron at a restaurant and the business is obviously the restaurant. To keep things simple, we are going to go through one customer question, but you can extrapolate that to what a typical day at this business would be like.

A customer goes to a local restaurant for dinner, known for it's quality food and service. The customer proceeds to ask an innocuous question:

> What locally sourced, vegetarian dishes do you have tonight?

### Breakdown of customer question

Now, using the method introduced above, let's start to break down the customer question. The points of interest for our technical translation are highlighted in bold:

> What **locally sourced**, **vegetarian** dishes do you have **tonight**?

Translating this question, it appears that there are three technical questions, which we need answers for to inform the customer. These are:

- What dishes we offer that are locally sourced AND vegetarian?
- Are these dishes available for tonight's service?

We can start to visually map out what we need so far:

![Query One](/images/img/SoT-Concepts-Query-One.png)

Next, we break to break down these business questions further into more specific queries of a SoT. The details of the SoT are irrelevant for now.

Starting with the first business question:

> What dishes we offer that are currently ;ocally sourced AND vegetarian?

We would need a query to find all dishes which are categorised as locally sourced AND vegetarian. In addition to this query, we would need to lookup the recipe details for each match and retrieve a list of ingredients needed to make each dish.

We can then use the data of dish name and ingredients to perform another query to check that all ingredients for a single dish are in stock so that the dish can be made. This answer to this query will resolve the answer to the second technical question:

> Are these dishes available for tonight's service?

Now we have a mapping or a process to determine the answer or solution to the original customer problem, as shown below:

![Final Query](/images/img/SoT-Concepts-Final-Query.png)


We have now explained the business process and what properties our SoT will need to address to solve our customer problem.

### Non-SoT Method


##### Non SoT method

Cooking staff refer to the menu, and ask the head chef which ones are matching dishes.
Then, they write down the list of recipe contents for each dish.
Finally, they go into the storeroom, and start validating whether those recipe contents exist and roll the data back into an answer for front of house.

##### Problems

The data is manually reconciled by humans, which means we are relying on them interpreting the menu correctly, not forgetting ingredents for the recipes and not miscalculating the ingredient stock levels. Accuracy of the answer is a concern, with little or no transparency into how the answer was gleaned.
The cost in terms of labour and elapsed time, a single question is costly. The time it would take to eventually give the customer an answer would lead to dissatisfaction. Who wants to wait 15 minutes for an answer to a "simple question"? Secondary, undesirable behaviours begin to creep in, where people speculate the answer of dish availability. This leads to an exacerbation of the problem, where customers think their dish is coming but an assumption was made that it was in stock.
Due to the elongated length of the query, we run the real risk that another business process is enacting the same task, rendering the timelineess of our answer outdated. Simply put, the age of our data becomes outdated to a point where the answer its cannot be trusted.

##### Partial, Manual SoT method

All stock items are counted at the commencement of each day. There is a recipe table which lists out the ingredients against each dish and is updated by the head chef. Each dish is classified with its characteristics:
- Vegetarian
- Chicken
- Beef
- Vegan
- Gluten Free
- Locally Sourced
- Seasonal

Prior to the first service, back end staff know how many meals of each type they can make and manually compile of list of dishes and their counts.

When the same query comes in, we have optimised some of the business process. We have rolled up some of the lower level details into "business answers". We can tell which dishes are vegetarian AND seasonal AND locally sourced by the categorisation improvement. We also have greater surety of the integrity of our answer by having a centralised location where dish levels are tracked for the service.

Solved the problem right?

Well, whilst we have a handle on "outgoings", another member of the team is accepting deliveries during the day and simply refilling the stock levels. They have another record of what deliveries they have received for that day. 

We have now reached our next problem. Back end staff are using the start of day stock levels to inform front end staff of dish availability. But front end staff and restaurant management can see that the answers they are being given, don't match with reality. They can see that there is ingredient stock for all recipe items for one dish, yet they are being told its unavailable. As reconciliation of stock data only happens daily, the accuracy of the answers are no longer timely as a result, they cannot be trusted.

The restaurant has a foundational problem, do we protect the integrity of the current system by "honouring" the start of day dish level answer, or do we regress back to the SoT being what we see with our eyes?
If we stick with the start of day dish level answer, we lose out on customer sales. If we don't, we inject more "cost" into the accuracy of our answers or worse sell items that we can't meet.

At no point in this scenario has anyone explicitly asked for a Source of Truth. Yet, every single persona in the supply chain and customer experience is only as effective as having timely, accurate and high integrity data, a Source of Truth. And really, who "owns" this problem? Is it the chefs, the waiters, the delivery team, procurement, management?

This is why Source of Truth is such a hard problem to solve. No team or business unit has a natural ownership or accountability. Due to the way companies can be structured, it can be challenging sourcing the financial and business sponsorship to adopt such a system. In the example above, with a restaurant of no more than twenty employees, silos had already formed. The delivery team had their own Source of Truth and the cooking team had their own as well. Can you imagine the scale of these challenges on an enterprise level? How would this restaurant manage this problem efficiently if they opened a second, third and fourth restaurant?

## Conclusion

This concludes this post in which we touched on some of the business problems which are caused by not having a Source of Truth or disparate Sources of Truth.

In the next post, we will move onto explaining the correlation between your business' fortunes and the adoption of their Source of Truth.

# ZZ old data

For example, if we were cloud consultants for a cloud consultancy, we would be considered "core business" to that particular business. In another example, if we were cloud consultants for a beveridge company, we wouldn't be considered "core business".

Most of IT falls into the second example, where we are not considered "core business". This can be labelled other names like support services or shared services. Take a moment to reflect upon your situation and determine whether your role is core business or not.

Unfortunately for those who are not considered "core business", we can have trouble correlating the tasks of the day or week back to the solving our customers problems.

It's important that I introduce these concepts early on, as everything mentioned in this series is meant to assist in solving customer problems or providing a differentiated services against it's competitors. In some scenarios, we are core business, sometimes not, but always we are aiming to work to solve the customers' problems.

## How do we solve customer problems?

In order to solve a customer's problems and be successful, we need a few key competencies:

1) The ability to thoroughly understand and comprehend the customers' definition of their problem
2) The ability to translate that problem into the right "technical solution". NOTE: The use of "technical solution" is used to represent the technical component of that industry, such as the trade/skill that it offers. For example, it might be landscaping, building databases etc.
3) The ability to use business data to make informed decisions about business operations and strategies which deliver those technical solutions.
4) The ability to execute the solution in an accurate and timely manner.

##

## Basic Customer Problem/Business Solution Workflow

To represent what a typical customer/business interaction is like, I've listed out some high-level steps below:

1) Customer and business discuss customer problem
2) Business takes customer problem, and translates that into one or more business problems
3) Business perform some analysis or queries on what is needed
4) Present customer with solutions

So in summary, we listen to a customer problem, translate that into business speak, 