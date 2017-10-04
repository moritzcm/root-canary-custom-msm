# root-canary-custom-msm
This repo is part of the Root Canary Project (rootcanary.org). It provides a script that queries a number of domains in order to measure the state of validation of recursive resolvers.
After the domains are queried, the results are sent to our central server to collect the measurements.

The script sends the following information back:

- For each queried domain:
    - The response code (NOERROR, SERVFAIL, ...)
    - The timestamp of the query
- The unique identifier (see *Setup*)
- The IP of the configured resolver

## Setup
Please run *setup.sh* first. This will create the file *uid.txt* in the current directory which will contain an unique identifier to let us keep track of resolver behavior over time.

The file *root-canary-msm.sh* contains the variable *resolver_ip*. Please fill in the IP address of your local recursive resolver (IPv4 or IPv6).
It also contains the variable *WORKINGDIR*. Please fill in the path where this script is located.

The file *msm-domains.txt* contains the list of URLs that the script queries.
