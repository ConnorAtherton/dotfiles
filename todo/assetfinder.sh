#!/bin/bash

# urlscan.io
curl --silent 'https://urlscan.io/api/v1/search/?q=domain:auction.com' | jq '.results[].task.url' | tr '[:upper:]' '[:lower:]' | uniq

# This one is noisy, since it includes wildcard certs that are out there in the wild
# curl --silent 'https://certspotter.com/api/v0/certs?domain=auction.com' | jq '.[] | .dns_names' | tr '[:upper:]' '[:lower:]' | uniq

# This one is kinda the same as above, so should likely be shuffled in there
curl --silent 'https://crt.sh/?q=auction.com&output=json' | jq '.[] | .name_value' | tr '[:upper:]' '[:lower:]' | uniq

# This one is exposed by a company that runs these kind of scans. Newline delimited return, along with IP attached.
curl --silent 'https://api.hackertarget.com/hostsearch/?q=auction.com'

# Same deal here, just threat scanning, but doesn't have as much info. Just using for subdomains, since that is useful.
curl --silent 'https://www.threatcrowd.org/searchApi/v2/domain/report/?domain=auction.com' | jq '.subdomains | .[]'

# Cybersecurity search engine. Has some interesting stuff in here
# Requires an API token, so not included in this script: https://spyse.com

# Lot of good information in this one, but needs some work to get it parsing well
# https://dns.bufferover.run/dns?q=.auction.com

