## Source of Truth - Where is the business value

### No CXO is going to ask you for a SoT

#### They will instead ask you (indirectly) for an aggegration of SoT data

### Breakdown/visualise the following

1) Customer question ->
2) Business question(s) ->
3) Sot Queries
    a) SoT Query 1
    b) SoT Query 2

Explain that the whilst no-one has explicitly asked for a SoT, only the SoT can give real-time, accurate and confident results.
These are rolled up into higher level questions, which eventually translate to a customar solution/answer


#### Example 1 - Restaurant

1) Customer Question - What seasonal, locally sourced, vegetarian dishes do you have tonight?
    - We need to break down the query, ask a series of sub-questions, collate the data and normalise it back to the customer
2) 
    a) What "season" are we in?  + What "locally sourced" dishes we serve? + @hat of those dishes are vegetarian?
    b) What is in stock and available to search the customer which match criteria 2a

3) Need to query people/systems or both to find out this information
    a) Query for all dishes which match the business query
    b) Perform another query on each eligible dish to get the recipe contents
    c) Query the inventory to ensure that all recipe items are in stock so that the order could be fufilled


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
