#!/bin/sh

echo .
read -p "Enter your SOOS Client Id (found here https://app.soos.io/integrate/dast): " clientId
read -p "Enter your SOOS API Key (found here https://app.soos.io/integrate/dast): " apiKey
read -p "Enter base URL of the site to scan (a full https URL only): " targetUrl
read -p "Enter the project name to use on SOOS (e.g. 'My Website'): " projectName
read -e -p "Enter the type of scan you would like to run (baseline, fullscan, or apiscan):" -i "baseline" scanMode
read -e -p "Vulnerability Level (PASS, IGNORE, INFO, WARN or FAIL):" -i "PASS" level
read -e -p "Enter the SOOS API url:" -i "https://api.soos.io/api/" apiURL

docker run -it --rm soosio/dast --clientId=$clientId --apiKey=$apiKey --projectName=$projectName --scanMode=$scanMode --ajaxSpider=true --level=$level --apiURL=$apiURL $targetUrl