#!/bin/sh
# This script is provided by the rootcanary.org Project
# It carries out DNS queries to a number of test domains 
# and reports a number of results back to the project partners.
# These results include: The response code of each DNS request, 
# the local resolver responsible for resolving the queries
# For questions and suggestions please contact
# Moritz at moritz.muller@sidn.nl

#Requirements
# dig, curl, grep, cut

# The path where this script and other rleated files are located
WORKINGDIR='/Users/moritz.muller/Documents/Projecten/Root_KSK_Rollover/custom_msm'

# The IP adress of the local resolver

resolver_ip="94.198.152.132"

# The unique identifier that helps us to track the measurments over time
# It is created when you run the setup.sh script
# Please don't change the uid. It helps us to keep track of resolver behavior over time

uid=$(cat $WORKINGDIR/uid.txt)
echo $uid

# The address to report the measurement results back to 

feedback_url="https://monitor.rootcanary.org/custom_msm/submit"

# Path to the file that includes the dig commands
# Only change the path if the the file is not in the same
# direcetory as this script

msm_domains_txt=${WORKINGDIR}"/msm-domains.txt"

# Please don't change these parameters

timeout_s=3

#################################
# The actual script starts here #
#################################


result_in_json='{"uid":'$uid', "resolver": "'$resolver_ip'", "queries": ['

while read DOMAIN
do

echo $DOMAIN 
response=$(dig A +time=$timeout_s +dnssec @$resolver_ip $DOMAIN)
response=$(echo $response | grep -o -E "status:\ [A-Z]+")
ts=$(date +%s)

if [ $? == 0 ] 
then

response=$(echo $response | cut -d ' ' -f2)
#echo $response
result_in_json=${result_in_json}'["'$DOMAIN'", ["'$response'",'$ts']], ' 

else

echo $?
result_in_json=${result_in_json}'["'$DOMAIN'", ["failure",'$ts']], '

fi 

done < $msm_domains_txt

result_in_json=${result_in_json%??}']}'
#echo $result_in_json
curl -i -H "Content-Type: application/json" -X POST -d "${result_in_json}" $feedback_url
