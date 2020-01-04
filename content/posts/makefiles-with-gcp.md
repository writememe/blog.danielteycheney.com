+++
title = "Makefiles With Google Cloud Platform"
date = 2020-01-04T20:03:11+10:00
tags = ["make", "gcp"]
categories = ["technical"]
draft = false
+++
# Makefiles with Google Cloud Platform

_This post will explore my first attempt at creating and using a Makefile to create a Google Cloud Platform (GCP) lab solution._

## Background

After recently completing my Amazon Web Services (AWS) Solutions Architect - Associate certification, I decided to spend time learning the fundamentals of the other two popular cloud offerings; Microsoft Azure and Google Cloud Platform (GCP). 

Being late to the cloud has arguably left me at a disadvantage, however it means I’m not particularly biased (yet) to one offering over another. 

Coupled with this, I maintain an ever growing [list of technologies or subjects](https://github.com/writememe/learn-list/blob/master/README.md), where I discover subjects I feel would be good to learn. One of those things was using Makefiles to automate deployments. 


## Scenario

As part of completing the [Google Certified Associate Cloud Engineer](https://acloud.guru/learn/gcp-certified-associate-cloud-engineer) course by A Cloud Guru, there are labs which you need to solve.

The lab is essentially implementing a solution from using knowledge gained from prior lessons to address the requirements of the lab. This solution can be implemented either via the GUI or via Cloud Shell. As a proponent of automation, I decided to avoid the ‘click-ops’ and attempt the Cloud Shell option.

So, I decided to solve this lab using a Makefile and executing commands using Google Cloud Shell.

### What is Cloud Shell?

[Google Cloud Shell](https://cloud.google.com/shell/) is a web-based command line access tool to access your GCP resources from any web browser. Some of the key features of this tool I found are:

- Pre-installed tools for development such as vim, git and basic file editor
- 5 GB of persistent disk storage, allowing for you to work on projects and pick up where you left off from another web browser
- Intuitive upload/download file facility to get files in and out of your Cloud Shell
- Run `gcloud` commands without the need to provide additional credentials or setup SSH keys against your project(s).

Azure have a similar web-based offering as well, although [slightly different](https://azure.microsoft.com/en-au/features/cloud-shell/).

### What is possible from the Cloud Shell?

Suprisingly, quite a lot. From within the Cloud Shell, you can perform some common development and automation tasks such as:

- Clone a repository using git, make changes and push changes back to the master branch
- Make directories/files to organise work from within your cloud shell
- Open the built-in editor if you aren’t comfortable with vim to edit/create/view files
- Perform all tasks through the GUI by using the `gcloud` equivalent command

Short of installing my own IDE, I haven’t found anything yet which has discouraged me from using it.

### How do I find out what gcloud command to use?

There are two main ways to find the commands:

- Perform the action through the GUI and prior to creating or deleting, there is a link provided to the equivalent **REST** or **command line**. Clicking on the **command line** will give you all the gcloud commands required to create it via the command line. This [link](https://cloud.google.com/shell/docs/running-gcloud-commands) is a good resource.
- Refer to the [gcloud Software Development Toolkit (SDK)](https://cloud.google.com/sdk/gcloud/reference/). Being Google, well the searches are alarmingly accurate and intuitive!

### Why use a Makefile?

The lab presented two main problems which would be difficult to update or maintain:


#### Problem One
There are variables repeated numerous times throughout the list of commands. Maintaining and updating multiple entries of this duplicate data should be handled in one location.  
#### Solution
_*Makefiles have a simple way of defining and using variables which are easy to be interpreted.*_
#### Problem Two 
The gcloud commands have dependencies on other resources being created or present, prior to them being executed. For example, a project must be created prior to being able to create a resource within that project.
#### Solution
_*Makefiles give you an explicit and simple dependency tree making it easy to follow the logic within the Makefile.*_


### Makefile - Take One

Initially, I broke down the two problems above with the intent of addressing defining variables first. As a result, I ended up with a monolithic single target in the Makefile below:

```console
# Populate with your variables
PROJECT_ID := gcp-lab-challenge-3255
# To retrieve your billing account id, run the command `gcloud alpha billing accounts list` from cloud shell
ACCOUNT_ID := 12345-654321-ABCDEF
DEFAULT_REGION := us-west1
DEFAULT_ZONE := us-west1-b
BUCKET = gs://gcp-challenge-lab-1-logging-2233/
INSTANCE_NAME = lab-vm-2

.PHONY: all

all: release

release:
	# Create new project
	gcloud projects create $(PROJECT_ID) --labels labid=gcp-lab-11-11
	# Check project is created
	gcloud projects describe $(PROJECT_ID)
	#Set the project for the current session
	gcloud config set project $(PROJECT_ID)
	# Get list of billing accounts
	gcloud alpha billing accounts list
	#Link billing account to project
	gcloud alpha billing accounts projects link $(PROJECT_ID) --account-id=$(ACCOUNT_ID)
	# Confirm billing account has been linked
	gcloud beta billing accounts --project=$(PROJECT_ID) list
	# Enable compute service
	gcloud services enable compute.googleapis.com
	# Add gcloud services compute default region and zone using variables above
	gcloud compute project-info add-metadata \
	    --metadata google-compute-default-region=$(DEFAULT_REGION),google-compute-default-zone=$(DEFAULT_ZONE)
	# Check that default region and zone is configured
	gcloud compute project-info describe
	# List compute services and ensure that they are enabled
	gcloud services list --enabled --filter=compute
	# List current buckets
	gsutil ls
	# Create storage bucket
	gsutil mb -l us $(BUCKET)
	# List created storage bucket
	gsutil ls $(BUCKET)
	# chmod Upload worker script file so that it is executable
	chmod +x worker-startup-script.sh
	# Create instance, using the `worker-startup-script.sh` as a startup script.
	gcloud compute --project=$(PROJECT_ID) \
	instances create $(INSTANCE_NAME) --description="GCE Lab Challenge 1" --zone=$(DEFAULT_ZONE) \
	--machine-type=f1-micro --image=debian-9-stretch-v20191121 --image-project=debian-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard \
	--boot-disk-device-name=instance-1 --reservation-affinity=any --metadata-from-file startup-script=./worker-startup-script.sh \
	--metadata lab-logs-bucket=$(BUCKET) --scopes=https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/trace.append,https://www.googleapis.com/auth/devstorage.write_only
	# Check that the instance is up
	gcloud compute instances list
	# Wait 300 seconds so that stress test can run and copy the file to the storage bucket
	sleep 300
	# Check that stress test results are in bucket
	gsutil cat $(BUCKET)machine-$(INSTANCE_NAME)-finished.txt

```

Whilst this worked, it wasn’t intuitive nor reusable. For example, If I simply wanted to deploy another instance, the current structure would error out on the create project commands given that project would already be created. 

### Makefile - Take Two

In the second attempt, I restructured the Makefile with numerous targets so that I had greater flexibility using the Makefile below:

```console
# Populate with your variables
PROJECT_ID := gcp-lab-challenge-54321
# To retrieve your billing account id, run the command `gcloud alpha billing accounts list` from cloud shell
ACCOUNT_ID := XXXXXX-XXXXXX-XXXXXX
DEFAULT_REGION := us-west
DEFAULT_ZONE := us-west1-b
BUCKET = gs://gcp-challenge-lab-1-logging-54321/
INSTANCE_NAME = lab-vm-2
LAB_LABELS = gcp-compute-lab-1

.PHONY: all

all: project-baseline compute

project-baseline: create-project set-project link-billing enable-compute create-bucket prepare-script

compute: set-project deploy-compute validate-compute

remove: unset-project delete-project

create-project:
	# Create new project
	gcloud projects create $(PROJECT_ID) --labels lab_id=$(LAB_LABELS)
	# Check project is created
	gcloud projects describe $(PROJECT_ID)
	
set-project:
	#Set the project for the current session
	gcloud config set project $(PROJECT_ID)
	
link-billing:
	# Get list of billing accounts
	gcloud alpha billing accounts list
	#Link billing account to project
	gcloud alpha billing accounts projects link $(PROJECT_ID) --account-id=$(ACCOUNT_ID)
	# Confirm billing account has been linked
	gcloud beta billing accounts --project=$(PROJECT_ID) list
	
enable-compute:
	#Enable compute service
	gcloud services enable compute.googleapis.com
	#Add gcloud services compute default region and zone using variables above
	gcloud compute project-info add-metadata \
	    --metadata google-compute-default-region=$(DEFAULT_REGION),google-compute-default-zone=$(DEFAULT_ZONE)
	# Check that default region and zone is configured
	gcloud compute project-info describe
	# List compute services and ensure that they are enabled
	gcloud services list --enabled --filter=compute
	
create-bucket:
	# List current buckets
	gsutil ls
	# Create storage bucket
	gsutil mb -l us $(BUCKET)
	# List created storage bucket
	gsutil ls $(BUCKET)
	
prepare-script:
	# chmod Upload worker script file so that it is executable
	chmod +x worker-startup-script.sh
	
deploy-compute:
	# Create instance, using the `worker-startup-script.sh` as a startup script
	gcloud compute --project=$(PROJECT_ID) \
	instances create $(INSTANCE_NAME) --description="GCE Lab Challenge 1" --zone=$(DEFAULT_ZONE) \
	--machine-type=f1-micro --image=debian-9-stretch-v20191121 --image-project=debian-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard \
	--boot-disk-device-name=instance-1 --reservation-affinity=any --metadata-from-file startup-script=./worker-startup-script.sh \
	--metadata lab-logs-bucket=$(BUCKET) --scopes=https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/trace.append,https://www.googleapis.com/auth/devstorage.write_only \
	--labels lab_id=$(LAB_LABELS)
	# Check that the instance is up
	gcloud compute instances list
	
validate-compute:
	# Wait 300 seconds so that stress test can run and copy the file to the storage bucket
	sleep 300
	# Check that stress test results are in bucket
	gsutil cat $(BUCKET)machine-$(INSTANCE_NAME)-finished.txt

unset-project:
    # Unset project for current session
	gcloud config unset project

delete-project:
	# Delete project and WITHOUT prompting the user to confirm
	gcloud projects delete $(PROJECT_ID) --quiet

```
Focusing on a specific excerpt of the Makefile, there are now four options on how to execute the Makefile:

```console
<excerpt omitted>
all: project-baseline compute

project-baseline: create-project set-project link-billing enable-compute create-bucket prepare-script

compute: set-project deploy-compute validate-compute

remove: unset-project delete-project

<excerpt omitted>
```

- `make project-baseline` will deploy the baseline functions required to create the project and prepare the environment for the compute component.
- `make compute` will deploy the compute component of the solution.
- `make` will deploy the project-baseline and the compute functions to build the solution for the project.
- `make remove` will delete the entire project.

Comparing this Makefile to the first attempt, it’s more intuitive as to what dependencies are required for each portion of the solution. 

Furthermore, it’s easy for someone who has no knowledge about GCP to comprehend what are the dependencies of the solution.

## Conclusion

Makefiles are an operating system independent, simple and effective way of automating deployments. They can also be used to "glue" together disparate automation solutions so that they are invoked and executed from a single file.  

I can see great potential in using them for future projects and in fact used one to publish this blog post.

## More Information

Below is a link to the above Makefile, along with a couple of other great resources:

[My Lab solution with Makefile (Github)](https://github.com/writememe/gcp-cloud-labs/blob/master/01-basic-compute-lab/EXERCISE.md)

[Mindlessness - Makefile tutorial with walkthrough](https://blog.mindlessness.life/2019/11/17/the-language-agnostic-all-purpose-incredible-makefile.html)

[Packet Flow - Makefile tutorial for Network Automation](https://www.packetflow.co.uk/netdevops-ci-cd-with-ansible-github-jenkins-and-cisco-virl-part-2-the-components-tools/#make)

Thanks for reading.
