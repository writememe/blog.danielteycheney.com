+++
title = "Blog Automation Part Three"
date = 2022-03-02T08:25:14+11:00
tags = [""]
categories = [""]
draft = false
+++

# Introduction

In this third blog post of [about the management of my site](https://blog.danielteycheney.com/tags/blog-as-code/), we will go through the first iteration of improvements.

## Background

In the final iteration, I wanted to automate spelling and component checks of my site, so that I could prevent trivial issues with the quality of my blog. I considered a few alternatives such as [PySpelling](https://facelessuser.github.io/pyspelling/), but ultimately I elected to go with [Vale](https://docs.errata.ai/vale/about). More on this later.

Secondly, I wanted to issue a new identity and access management (IAM) user with the most restrictive access as possible. This IAM user should only be able to have permissions to perform the tasks directly related to the S3 bucket and the CloudFront distribution ID.

Finally, although not an explicit goal, I wanted to optimise the Github Actions configuration to use branch protection features to prevent deviations from the process and remove any duplication of jobs.


## Final Iteration Workflow

The end state at the end of the final iteration is shown below:

![Blog Final Iteration](/images/img/Blog-Final-Iteration.png)

Note that the only difference to the workflow is the automation of the editorial review, which I will go into more detail below.

### Editorial Review

As mentioned above, I have decided to automate the  spelling, grammar and writing style checks using Vale. 

Vale is a command-line tool that brings code-like linting to prose, It's written in Golang and works on multiple platforms.

Some of the key features of using Vale are:

- Support for markup files, which is perfect for this use-case
- Flexible extension system, so that you can enforce an editorial writing style
- Easy-to-install and comes in a standalone binary, supported on multiple platforms

The Github documentation for Vale has a [functionality table](https://github.com/errata-ai/vale/#functionality) which explains it benefits against alternatives. 

We will now go through the components which comprise the Vale linting checks.

#### Vale Components

The main components of Vale are as follows:

- [*Configuration File*](https://docs.errata.ai/vale/config) - An INI configuration file where you can configure core settings, format associations, and format-specific settings.
- [*Styles*](https://docs.errata.ai/vale/styles) - A powerful extension system to fully customise your own writing style or spelling checks.
- [*Vocab*](https://docs.errata.ai/vale/vocab) - A way to maintain custom lists of terminology independent of your styles.

I will now expand on how each component is configured for my site.

#### .vale.ini - Vale Configuration File

The vale configuration file is used to control the majority of Vale's behavior, including what files to lint and how to lint them. The file adopts the [INI configuration format](https://ini.unknwon.io/docs/intro)
to manage the configuration.

I will refer to snippets of code, so please use the [copy on my Github repo](https://github.com/writememe/blog.danielteycheney.com/blob/master/.vale.ini) which will display with line numbers included as a reference when following along:

```ini
# Vale configuration file
# Docs: https://docs.errata.ai/vale/config

# Define the styles/ directory as the path to find styles configuration
StylesPath = "styles"

# Only alert on errors
MinAlertLevel = error

# Specify a vocabulary called 'Blog'. This will contain any exception words.
Vocab = Blog

# Use Vale, write-good, Microsoft, Readability and Google styles for editorial checks on Markdown files only
[*.md]
BasedOnStyles = Vale, write-good, Microsoft, Readability, Google

# Tune the usage of exclamation in text down to 'warning' level.
Google.Exclamation = warning
```

On lines 1 to 3, I am documenting what this file is for. I like to do this where possible so I remember what it does, but also help others looking at the repo:

```ini
# Vale configuration file
# Docs: https://docs.errata.ai/vale/config
```

I will be using Vale styles to add editorial writing style and spelling checks to the site. Therefore, we need to tell Vale which directory the styles folders can be found as per lines 4 to 5:

```ini
# Define the styles/ directory as the path to find styles configuration
StylesPath = "styles"
```

Vale has three types of alert levels; `suggestions`, `warnings`, and `errors`. By default, it will alert on `warnings` and `errors`. In lines 7 to 8, I am adjusting the alerting to only inform me of `errors` as the alerting is overwhelming for an existing content repository with approximately 15,000 words. If I was starting a new content repository from scratch, it would be worth leaving the level at default:

```ini
# Only alert on errors
MinAlertLevel = error
```

Next, we want to specify a Vocab, which we can use to maintain custom exception words on lines 9 to 10. We will go into this later, but it's essentially a list of words which might not be in a standard dictionary, but you've whitelisted as legitimate words.

```ini
# Specify a vocabulary called 'Blog'. This will contain any exception words.
Vocab = Blog
```

On lines 13 to 15, we're configuring Vale to perform five different writing style checks across all markdown extension files in the repo. These styles are the [official styles provided by Vale](https://github.com/errata-ai/styles#available-styles), but there is nothing preventing you writing your own. In fact, [many companies have written their own writing styles](https://docs.errata.ai/community#examples)

```ini
# Use Vale, write-good, Microsoft, Readability and Google styles for editorial checks on Markdown files only
[*.md]
BasedOnStyles = Vale, write-good, Microsoft, Readability, Google
```

Finally, the [Google writing style doesn't like the usage of exclamation points in text](https://developers.google.com/style/exclamation-points). Note that this is configured in the [Google Exclamation YAML configuration file](https://github.com/errata-ai/Google/blob/17be3489c9a9cf8ce451949af09c8f6f5642afa4/Google/Exclamation.yml) for reference. I like to use exclamation points, so I've tuned the alert level down from `error` to `warning` on lines 17 to 18.


```ini
# Tune the usage of exclamation in text down to 'warning' level.
Google.Exclamation = warning
```

#### Styles

Styles are used by Vale to enforce particular writing constructs. An individual style is made up of a collection of YAML files, also known as rules.

An example of a rule is below:

```yaml
# An example rule from the "Microsoft" style.
extends: existence
message: "Don't use end punctuation in headings."
link: https://docs.microsoft.com/en-us/style-guide/punctuation/periods
nonword: true
level: warning
scope: heading
action:
  name: edit
  params:
    - remove
    - '.?!'
tokens:
  - '[a-z0-9][.?!](?:\s|$)'
```

The collection of YAML files are housed inside a folder, which must correlate with the `BasedOnStyles` setting in the Vale configuration file.

In this project, we're using the following five styles for this site:

- Vale (built-in style)
- [Google](https://github.com/errata-ai/Google/)
- [write-good](https://github.com/errata-ai/write-good/)
- [Microsoft](https://github.com/errata-ai/Microsoft)
- [Readability](https://github.com/errata-ai/Readability)

Each have their own benefits, but by using multiple style linters, I get better coverage.

#### Vocab

Vocabularies (or Vocab) are a way to maintain custom lists of terminology independent of your styles. Within this repository, I use a lot of network or automation specific words which would
normally fail spell checks. The name of the Vocab configured in the configuration file is called `Blog`. This aligns with the file structure below:

```bash
styles/
└──  Vocab
    └── Blog
       └── accept.txt
```

Within the `accept.txt` file, you can add individual entries or use regular expression to match multiple accepted words. A truncated output is shown below:

```bash
head -n 20 styles/Vocab/Blog/accept.txt 
(?i)Ansible
automators
blowback
boolean
Catalin
config
dfjt
gcloud
getters
Github
(?i)Hostname
impactful
incentivised
Makefil(e|es)
(i|e|jun|nx)os
Mihai
minimalistic
nautobot
(?i)netbox
(?i)netmiko
```
These regular expression patterns or words are added to every exception list in all styles listed in `BasedOnStyles`, meaning that you now only need to update your project's vocabulary to customize third-party styles (rather than the styles themselves). 

The full Vocab file can be found at this [link.](https://github.com/writememe/blog.danielteycheney.com/blob/master/styles/Vocab/Blog/accept.txt)

#### Github Actions - Vale Editorial Review

After going through the main components which make up Vale, I will now show how I use Github Actions to automate the editorial review.

I will refer to snippets of code in the Github Actions workflow file, so please use the [copy on my Github repo](https://github.com/writememe/blog.danielteycheney.com/blob/master/.github/workflows/vale.yml) which will display with line numbers included as a reference when following along:


```yaml
---
name: Vale - Editorial Review
on:  # yamllint disable rule:truthy
    push:
        branches:
            - feature/*

jobs:
    prose:
        runs-on: ubuntu-latest
        steps:
            - name: Checkout
              uses: actions/checkout@master
            - name: Vale - Editorial Review
              uses: errata-ai/vale-action@v1.5.0
              with:
                  # Use Vale, write-good, Microsoft, Readability and Google styles for editorial style review.
                  styles: |
                      https://github.com/errata-ai/Microsoft/releases/latest/download/Microsoft.zip
                      https://github.com/errata-ai/write-good/releases/latest/download/write-good.zip
                      https://github.com/errata-ai/Google/releases/latest/download/Google.zip
                      https://github.com/errata-ai/Readability/releases/latest/download/Readability.zip
                  files:
                      content/
              env:
                  # Required, set by GitHub actions automatically:
                  # https://docs.github.com/en/actions/security-guides/automatic-token-authentication#about-the-github_token-secret
                  GITHUB_TOKEN: ${{secrets.GITHUB_TOKEN}}
```

On line 2, I name the workflow `Vale - Editorial Review` so that it's different from the other workflow used to build and deploy the site.

```yaml
---
name: Vale - Editorial Review
```

On lines 3 to 6, we're specifying to trigger this workflow on any pushes to branches which meet the `feature/*` pattern. This means when I create a branch using my feature naming standard convention.

Note that there this workflow won't trigger on pushes to the `master` branch. We could potentially get into a situation where our editorial review wouldn't run with a direct commit to `master`. This is mitigated by using branch protection which I will cover in a later section.

On lines 8 to 9, we're configuring Github Actions to run the `job` named `prose`.

```yaml
jobs:
    prose:
```

On lines 10 to 13, we're performing this action on an `ubuntu-latest` runner and checking out the repositories code.


```yaml
        runs-on: ubuntu-latest
        steps:
            - name: Checkout
              uses: actions/checkout@master

```

On lines 14 to 15, I am using [official Github Action for Vale](https://github.com/errata-ai/vale-action), to simplify my setup and configuration:


```yaml
            - name: Vale - Editorial Review
              uses: errata-ai/vale-action@v1.5.0
```

The final lines of code are inputs to the Github Action, which are described more below.

On lines 16 to 22, I am configuring the runner to use the five writing styles when performing the Vale checks:

```yaml
              with:
                  # Use Vale, write-good, Microsoft, Readability and Google styles for editorial style review.
                  styles: |
                      https://github.com/errata-ai/Microsoft/releases/latest/download/Microsoft.zip
                      https://github.com/errata-ai/write-good/releases/latest/download/write-good.zip
                      https://github.com/errata-ai/Google/releases/latest/download/Google.zip
                      https://github.com/errata-ai/Readability/releases/latest/download/Readability.zip
```

On lines 23 to 24, we'ew specifying to only perform the checks on the top level `content/` directory. This is where the Markdown files for the site are hosted:

```yaml
                  files:
                      content/
```

On lines 25 to 28, we're addressing a limitation with the current workflow which is documented [here.](https://github.com/errata-ai/vale-action#limitations)

```yaml
              env:
                  # Required, set by GitHub actions automatically:
                  # https://docs.github.com/en/actions/security-guides/automatic-token-authentication#about-the-github_token-secret
                  GITHUB_TOKEN: ${{secrets.GITHUB_TOKEN}}
```

#### CI Examples

To show that this workflow actually detects errors, I will deliberately misspell a word, not use proper spacing after a sentence, and not contract words correctly.

Does not look like fun.
The end.Is near.
I can't spell chiar.

The outputs of the workflow are shown below:

### IAM Role

Setup a new user with the following:


```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "cloudfront:ListDistributions",
                "cloudfront:ListStreamingDistributions"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "s3:DeleteObjectVersion",
                "cloudfront:GetInvalidation",
                "s3:ListBucket",
                "cloudfront:CreateInvalidation",
                "s3:PutObject",
                "s3:GetObjectAcl",
                "s3:GetObject",
                "cloudfront:GetDistribution",
                "cloudfront:GetStreamingDistribution",
                "cloudfront:ListInvalidations",
                "s3:DeleteObject",
                "cloudfront:GetDistributionConfig",
                "s3:PutObjectAcl",
                "s3:GetObjectVersion"
            ],
            "Resource": [
                "arn:aws:s3:::<S3_BUCKET_NAME>",
                "arn:aws:s3:::<S3_BUCKET_NAME>/*",
                "arn:aws:cloudfront::<ACCOUNT_ID>:distribution/<DISTRIBUTION_ID>",
                "arn:aws:cloudfront::<ACCOUNT_ID>:streaming-distribution/<DISTRIBUTION_ID>"
            ]
        }
    ]
}
```

The following substitutions were made on the JSON policy document:

- `<S3_BUCKET_NAME>` - Is the name of my S3 bucket
- `<ACCOUNT_ID>` - Is my account ID
- `<DISTRIBUTION_ID>` - Is my CloudFront distribution ID


<!-- vale off -->
We can turn checks off :)
<!-- vale on -->