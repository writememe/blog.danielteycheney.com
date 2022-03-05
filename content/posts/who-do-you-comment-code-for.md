+++
title = "Who do you comment code for?"
date = 2020-05-05T19:16:09+10:00
tags = ["technical"]
categories = ["programming"]
draft = false
+++

Recently, I've been working with some new programming languages. I've been looking at reference code, as well as reading documentation to develop solutions or features for my new role.

Naturally, I had some questions about the language itself and why certain solutions were chosen over others.

Sometimes, I received a clear, concise and articulated reason. Other times, this was met with *"I don't know why that's there, person x implemented it before I started."* And sometimes, the programmer couldn't remember why that code they wrote was there...

These experiences aren't unique and I fully anticipate to have this happen again in future. It's with this that I asked myself, who do you comment code for?

## Future me ##

As part of commenting my code, the very first person I comment code for is the future me. Me being, well me, I know that I have the following traits:

- I will forget the intent or context of the code, as naturally other important/non-important items will consume my short-term and long-term memory.
- I can be distracted, either out of changing priorities, impromptu meetings or other life interruptions.
- The *"I'll get around to commenting up my code"* won't happen or will have diminishing returns if isn't done within 24 to 48 hours of getting code working.


Whilst no-one can predict the future, we can take an educated guess that code will need to be maintained over the lifetime of its use. As such, future me is likely going to have to maintain it or hand it over to someone else.

- Following the path of least resistance, naturally future me will be asked about how the code works, why was solution x used instead of solution y. Future me will appreciate commented code!
- Some solutions in the current code I'm writing are most likely going to be useful for future projects. Comments will allow me to efficiently assess whether this code could solve my future problem.
- Future me will most likely have more experience with the language, and has probably discovered better solutions to the problems in the current code. Understanding what the original problem or intent is makes it easier to refactor.


## Fellow colleagues ##

Next, I comment code for my fellow colleagues. The reasoning for commenting for them is:

- Most programmers like to self-serve, by reading the code and getting an understanding of what's currently implemented. If it's not clear, they now need to involve me (the path of least resistance).
- If something sub-optimal or weird has been implemented, commenting can help clarify why it was done that way.
- Most colleagues have different skill levels or perspectives, and may be able to suggest a better way to solve the same problem.
- If the code needs to be handed over, it's more likely to be received more positively by your fellow colleagues.


## Example code ##

I try to be as detailed as possible when commenting code. Whilst this might seem like a waste of effort, it allows me to leave the code and the original intent in a legible state. This can be picked up in a weeks time, but the longer it's left, the higher the chance that context and meaning will be lost without those detailed comments.

The example code below is a Python function that I had written nearly two years ago:

```python
def collect_getters(task, getter):
    """
    This function is used to collect all applicable getters for the applicable OS
    and then store these results under the respective facts/<hostname>/ directory.
    :param task: The name of the task to be run.
    :param getter: The name of the NAPALM getter.
    :return: An AggregatedResult of this task.
    """
    # Assign facts directory to variable
    fact_dir = "facts"
    # Assign hostname directory to a variable
    host_dir = task.host.name
    # Assign the destination directory to a variable. i.e facts/hostname/
    entry_dir = fact_dir + "/" + host_dir
    # Create facts directory and/or check that it exists
    pathlib.Path(fact_dir).mkdir(exist_ok=True)
    # Create entry directory and/or check that it exists
    pathlib.Path(entry_dir).mkdir(exist_ok=True)
    # Try/except block to catch exceptions, such as NotImplementedError
    try:
        # Gather facts using napalm_get and assign to a variable
        facts_result = task.run(task=napalm_get, getters=[getter])
        # Write the results to a JSON, using the convention <getter_name>.json
        task.run(
            task=write_file,
            content=json.dumps(facts_result[0].result[getter], indent=2),
            filename=f"" + str(entry_dir) + "/" + str(getter) + ".json",
        )
    # Handle NAPALM Not Implemented Error exceptions
    except NotImplementedError:
        return "Getter Not Implemented"
    # Handle NAPALM Attribute Error exceptions
    except AttributeError:
        return "AttributeError: Driver has no attribute"
```

Hopefully, you can probably tell roughly what's the intent of the code, even if you aren't proficient in Python.

Thanks for reading, and if you'd like to discuss, feel free to contact me on [Twitter](https://twitter.com/danielteycheney) or [LinkedIn](https://www.linkedin.com/in/danielfjteycheney/)

