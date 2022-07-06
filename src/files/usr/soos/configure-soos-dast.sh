#!/bin/bash

clear
echo
echo "Welcome to SOOS! Let's configure a DAST scan:"
echo
echo "You will need your Client ID and API Key from the website:"
echo "   https://app.soos.io/integrate/dast"
echo
read -p "Enter your SOOS Client ID: " clientId
read -p "Enter your SOOS API Key: " apiKey
read -p "What HTTPS URL would you like to scan? " targetUrl
read -p "Which project name should be used on SOOS (e.g. 'My Website'): " projectName

command="docker run -it --rm soosio/dast --clientId=$clientId --apiKey=$apiKey --projectName=\"$projectName\" --scanMode=baseline --ajaxSpider --level=PASS --apiURL=https://api.soos.io/api/ $targetUrl"

cleanedProjectName=$(printf '%s' "$projectName" | sed -E 's/[^[:alnum:]]+/-/g' | awk '{print tolower($0)}')
commandScript=/usr/soos/run-soos-dast-$cleanedProjectName.sh

echo "#!/bin/bash

echo "Starting your DAST scan of $targetUrl now..."

$command

" > $commandScript

chmod +755 $commandScript

read -e -p "Would you also like to run the scan now? " -i "Yes" runNow
if [ "${runNow,,}" = "yes" ]; then
  source $commandScript
fi

echo
echo
echo "The configuration has been saved to the run script:"
echo
echo "$commandScript"
echo
echo "There are numerous other command line options available."
echo "See https://github.com/soos-io/soos-dast for more information."
echo
echo "Thank you for using SOOS!"
echo

