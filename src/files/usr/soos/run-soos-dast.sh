#!/bin/bash

echo
echo "Welcome to SOOS! Let's configure a DAST scan:"
echo
read -p "Paste your SOOS Client Id (found here https://app.soos.io/integrate/dast): " clientId
read -p "Paste your SOOS API Key (found here https://app.soos.io/integrate/dast): " apiKey
read -p "Enter base URL of the site to scan (a full https URL only): " targetUrl
read -p "Enter the project name to use on SOOS (e.g. 'My Website'): " projectName
read -e -p "Enter the type of scan you would like to run (baseline, fullscan, or apiscan): " -i "baseline" scanMode
read -e -p "Vulnerability Level (PASS, IGNORE, INFO, WARN or FAIL): " -i "PASS" level
read -e -p "Enter the SOOS API url: " -i "https://api.soos.io/api/" apiURL
echo

command="docker run -it --rm soosio/dast --clientId=$clientId --apiKey=$apiKey --projectName=\"$projectName\" --scanMode=$scanMode --ajaxSpider=true --level=$level --apiURL=$apiURL $targetUrl"

cleanedProjectName=$(printf '%s' "$projectName" | sed -E 's/[^[:alnum:]]+/-/g')
commandScript=./run-soos-dast-$cleanedProjectName.sh

echo "#!/bin/bash

$command

" > $commandScript

chmod +777 $commandScript

echo "We've saved your configuration to $commandScript".
echo

read -e -p "Would you also like to run the scan now? " -i "Yes" runNow
if [ "${runNow,,}" = "yes" ]; then
  echo "Starting your DAST scan of $targetUrl now..."
  eval $command
fi


