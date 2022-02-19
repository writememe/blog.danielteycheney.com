+++
title = "Source of Truth Series - Business Value"
date = 2021-11-24T18:07:31+11:00
tags = ["sot"]
categories = ["source-of-truth"]
draft = false
+++

# Introduction

In the [next post about Source of Truth (SoT)](https://blog.danielteycheney.com/tags/sot/), I am going to explain the role of a Source of Truth (SoT), in context of business operations and how it's presence can provide demonstrative value to any business setting.

## Problems and Solutions

At a fundamental level, all businesses exist by providing solutions to customer problems. We are employed to add some form of value which should directly or indirectly solve customer problems. If we break down our value to the business further, we fall into one of the following categories:

- *Core Business* - Where our team or department is main is the main source of a companies profits or success. For example, a landscaper at a landscaping services company
- *Non Core Business* - Where our team or department provides a supporting role to the core business operation. It's sometimes is named "support services" or "shared services". For example, a cloud engineer at an agricultural company.

The vast majority of IT roles are non core business, so it can be difficult to demonstrate the business value of activities we undertake. Therefore, often we can be on the back foot and perceived as an "overhead" or an "expense" and justifying large, multi department undertakings is met with resistance.

When considering the role of a SoT within your environment, it's important to show the correlation between this non-core business activity and the direct success of the core business. 

## Data drives all business

As we begin to adopt more automation into modern businesses, we begin to realise that data is the enabler (or blocker) of a companies success. With globalisation, increased competition and evolving markets, having high-integrity data is often the difference. Important business decisions are more time sensitive, complex and nuanced. The most successful business thrive by valuing data, and harnessing it's value to make more correct decisions than not.

A SoT is one method of governing and managing your business data, so that you can operate and strategise from solid foundations.

## How does a SoT and data provide business value?

In the diagram below, we are representing the basic relationship between the customer, the business and solving their problem:

![Business Question](/images/img/SoT-Concepts-Overview.png)

Going through this diagram from top to bottom, the components are described below:


#### Customer Question/Problem

The customer will have a problem, or a question that they have come to your business about. 

> I will use these interchange these terms of __**problem**__ and __**question**__ throughout the rest of this post as they mean the same thing in the context of this post.

This is where one would receipt the problem, ask any qualification questions or clarify what would be deemed successful for the customer. These problems or questions are rarely technical, and are often so abstract from the work needed to provide a solution. 

For example, _I'd like to buy a used European electric car today, do you have any which you can show me?_

#### Business Question

After we have documented and clarified the customers' question, we now need to translate their non-technical question into one or more business questions. These are the inception of possible solutions to the customers original problem. Whilst they are now in a technical state, they still don't provide us with a level of detail to ask distinct questions or queries of our data to devise a proper solution. 


Expanding on the example above, we may have two business questions:

- _Do we have any used European electric cars in our possession?_
- _If so, are they ready for sale?_


#### SoT Query

Whilst there are often other things we need to do to solve a customers problem, we are going to scope this example to needed some sort of business data to make a decision or offer a solution. In this phrase, we break down the business question into a smaller queries which we make of a SoT to find low level detail about our business data. These example queries could be:

- **Query One:** Find all European used cars which are electric
- **Query Two:** Find all cars which match Query One, and have the status of READY FOR SALE

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

Translating this question, it appears that there are two technical questions, which we need answers for to inform the customer. These are:

- What dishes we offer that are locally sourced AND vegetarian?
- Are these dishes available for tonight's service?

We can start to visually map out what we need so far:

![Query One](/images/img/SoT-Concepts-Query-One.png)

Next, we break to break down these business questions further into more specific queries of a SoT. The details of the SoT are irrelevant for now.

Starting with the first business question:

> What dishes we offer that are currently locally sourced AND vegetarian?

We would need a query to find all dishes which are categorised as locally sourced AND vegetarian. In addition to this query, we would need to lookup the recipe details for each match and retrieve a list of ingredients needed to make each dish.

We can then use the data of dish name and ingredients to perform another query to check that all ingredients for a single dish are in stock so that the dish can be made. This answer to this query will resolve the answer to the second technical question:

> Are these dishes available for tonight's service?

Now we have a mapping or a process to determine the answer or solution to the original customer problem, as shown below:

![Final Query](/images/img/SoT-Concepts-Final-Query.png)


We have now explained the business process and what properties our SoT will need to address to solve our customer problem.

In the proceeding section, we will compare two examples
of retrieving the SoT data, so that we can answer the customers original intention.

### Non-SoT Method

In this first example, there is no SoT in place at all. Let's walk through the interactions and high-level steps at play:

1) Waiter asks cooking staff member the two business questions **What dishes we offer that are locally sourced AND vegetarian?** and **Are these dishes available for tonight's service?** as they are unsure which dishes are eligible, as the menu has no information recorded about the dishes' characteristics.
2) Cooking staff is unsure, and asks the head chef. The head chef verbally responds with the eligible dishes.
3) Cooking staff scribbles down the eligible dishes on a piece of paper.
4) Cooking staff then looks up each recipe, and on another piece of paper, transcribes the dish name and ingredients for each dish.
5) Cooking staff goes into the storeroom, and starts to manually tick off all the ingredients for each dish or leaves them unticked is they are out of stock.
6) Cooking staff now knows which dishes are **locally sourced AND vegetarian** and **available for tonight's service**, based on those items being in stock at the time of their stocktake.
7) Cooking staff tells waiter which dishes **locally sourced AND vegetarian** and **available for tonight's service**.
8) Waiter informs the customer which dishes **locally sourced AND vegetarian** and **available for tonight's service**.

#### Observations

There are some interesting observations here, some of which are easy to point out where things can be optimised, or where things can go wrong. Below are some of the easy ones to identify:

- Steps 1 and 2 could be optimised, by having a coded menu indicating a dishes characteristics. For example, **vegetarian**, **vegan**.
- Step 2 is misusing a highly paid member of the business operation to answer a trivial question. Furthermore, when similar requests come in, this staff member won't be able to scale and answer all these questions whilst performing other duties. They are the [constraint](https://www.tocinstitute.org/theory-of-constraints.html) of the process.
- Steps 3 to 5 are all manual, and are reliant on the cooking staff not being interrupted, correctly transcribing details or interpreting them correctly. At scale, there is would a large variation on the quality of this work and we would repeatedly count the same ingredients over the course of a day.
- In Step 6, our ingredient stock level is the physical stock itself, with no higher level abstraction of this data. The cost to query for this data is expensive, particularly in relation to the business benefit. In other words, reconciliation of the data is potentially happening tens of times per service.
- The elapsed time for the entire process would be lengthy, and certainly wouldn't fill the customer with confidence.

### Partial, Manual SoT Method

In this second example, some improvements have been made. Below is a list of improvements, to improve upon the first example:

- The head chef maintains a dish table (or database), which details the following characteristics about each dish on the menu like the example below:

| Dish Name| Vegetarian| Vegan|  Meat Type| Locally Sourced| Ingredients and Quantities|
| ---------|-----------|------| ---------|----------------|----------|
| Zucchini Fritters|True|False|None|True|400g zucchini, 100g buckwheat flour, 30g olive oil|

- All stock items are counted at the commencement of each day. This stock count is kept with the cooking staff, who subtract items off as they are prepared from a central location within the cooking station.

With these two optimisations, we are no longer querying the constraint for the recipe characteristics, nor are we wasting time during service to know whether we can serve a meal (or not).

Let's walk through the interactions and high-level steps at play:

1) Waiter is able to query the menu and see which dishes are **vegetarian**, but the **locally sourced** information is not kept on the menu due to the dynamic nature of suppliers.
2) Cooking staff lookup dish table, provided by the head chef and can determine which dishes are **vegetarian** and **locally sourced**.
3) Cooking staff then lookup the stock levels, which are being updated as dishes go out. From this, they can determine whether all the ingredients are in stock or not.
4) Cooking staff tells waiter which dishes **locally sourced AND vegetarian** and **available for tonight's service**.
5) Waiter informs the customer which dishes **locally sourced AND vegetarian** and **available for tonight's service**.

#### Observations

Below are some of the observations, we will start out with the obvious ones:

- They have now optimised some of our data about the dishes we offer and removed the constraint from the process.
- They have also done some work to remove the repeat counting of the same item(s) and return more time for cooking staff to focus on cooking.
- In other words, they have rolled up some of the lower level details into "business answers".
- Whilst the customer's question isn't answered immediately, the waiter can return a response in a shorter elapsed time, which marks an improvement.

So it's seems they've solved the problem and have a workable solution right?

### It's complicated

Well, whilst we have a handle on "outgoings", another member of the team is accepting deliveries during the day and simply refilling the stock levels. They have another record of what deliveries they have received for that day. 

We have now reached our next problem.

Cooking staff are using the start of day stock levels to inform front of house staff of dish availability.
But the front of house staff and restaurant management can see that the answers they are being given don't match with reality (the stockroom). They can see that there is ingredient stock for all recipe items for one dish, yet they are being told its unavailable. As reconciliation of stock data only happens daily, the accuracy of the answers are no longer timely as a result, they cannot be trusted.

The restaurant has a foundational problem. 

> Do we protect the integrity of the system in the second example by "honouring" the start of day dish level answer, or do we regress back to the SoT being what we see with our eyes which we did in the first example?


If we stick with the start of day dish level answer, we lose out on customer sales. If we don't, we inject more "cost" into the accuracy of our answers or worse sell items that we can't meet.

### We need a better approach and solution

At no point in this scenario has anyone explicitly asked for a Source of Truth. Yet, every single persona in the supply chain and customer experience is only as effective as having timely, accurate and high integrity data, a Source of Truth. 

You might be thinking, who "owns" this problem? Is it the cooking staff, front of house, the delivery team, procurement, management?

This is why Source of Truth is such a hard problem to solve. No team or business unit has a natural ownership or accountability. Due to the way companies can be structured, it can be challenging sourcing the financial and business sponsorship to adopt such a system. In the example above, with a restaurant of no more than twenty employees, silos had already formed. The delivery team had their own Source of Truth and the cooking team had their own as well.

Can you imagine the scale of these challenges on an enterprise level?

How would this restaurant manage this problem efficiently if they opened a second, third and fourth restaurant?

## Conclusion

This concludes this post in which we touched on some of the business problems which are caused by not having a Source of Truth or disparate Sources of Truth.

In the next post, we will move onto explaining the correlation between your business' fortunes and the adoption of their Source of Truth.

Thank you for reading.