+++
title = "Blog as Code Summary"
date = 2022-03-01T14:02:07+11:00
tags = [""]
categories = [""]
draft = false
+++

# Structure

- [x] ~~Give background~~
- [x] ~~Introduce current workflow~~
- [x] ~~Introduce current tooling~~
- [x] ~~Talk about current limitations~~
    - [x] ~~Keep finding spelling mistakes~~
    - [x] ~~Have to store AWS keys on my local machine~~
    - [x] ~~Not automated and feels dodgy~~

# First iteration

- [x] ~~Talk about primary goals~~
    - [x] ~~Move off local deployment model~~
    - [x] ~~Use GH actions to automate build and deploy.~~

- [ ] Talk about setting up a restrictive IAM policy/role/user/group for this job
    - [ ] Only needs CloudFront and S3 access to specific bucket and distribution ID
    - [ ] Google sitemap doesn't need credentials

- [x] Run through the GH actions workflow file
- [x] Run through the GH repo secrets
- [x] Show an output of GH action running correctly

# Final iteration

- [ ] Talk about spelling and grammar issues
    - [ ] Little bit embarrassing
    - [ ] I know surely someone has automated this before
- [ ] Introduce Vale
    - [ ] Talk about its features
    - [ ] Mention we're only using it for spelling, grammar and terms for now
- [ ] Introduce the vale configuration file
- [ ] Introduce the accept file
- [ ] Introduce the Github actions file
- [ ] Show an output of it working correctly
- [ ] Make a spelling and grammar error, show the GH actions file where it picks this up
- [ ] Show how the entire workflow works.

# Bonus section

- [ ] Talk about branch protection
    - [ ] Branch protection applied to master
    - [ ] Requires one approval
    - [ ] Status check must pass before merging code
- [ ] Show a naughty direct commit

they is
