# blog.danielteycheney.com

This repository is used to maintain my blog.

## Setup

Below is the procedure to get this repository working:

### Step 1 - Clone Repository (including submodules)

Clone this repo, plus the theme dependency using the following command:  

```commandline
git clone --recursive https://github.com/writememe/blog.danielteycheney.com.git
```

## Changes

Below are the ways to make standard changes to the website.

### New Posts

To create new posts, issue the following command:

```python
hugo new posts/<name-of-post>.md
```
Whereby `<name-of-post>` is the name of your post.

Populate the markdown file with the associated content.

[Reference Documentation](https://gohugo.io/getting-started/quick-start/#step-4-add-some-content)

### Render/Build the website

To build the website use the following command:

```python
hugo
```

[Reference Documentation](https://gohugo.io/getting-started/usage/#the-hugo-command)
