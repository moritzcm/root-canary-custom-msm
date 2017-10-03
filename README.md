# root-canary-custom-msm
This repo is part of the Root Canary Project (rootcanary.org). It provides a script that queries a number of domains in order to measure the state of validation of recursive resolvers.

## Setup
Please run setup.sh first. This will create the file *uid.txt* in the current directory which will contain an unique identifier to keep us track of resolver behavior over time.

The file *root-canary-msm.sh* contains the variable *resolver_ip*. Please fill in the IP address of your local recursive resolver.

The file *msm-domains.txt* contains the list of URLs that the script queries.
