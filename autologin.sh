#!/bin/bash
#simple script checking connection and autologin to captive portal

#extract post url with browser developer tool and put it in url file
#extract query with browser developer tool and put it in query file

#make autologin.sh executable
#chmod +x autologin.sh

#change path and add to cronetab -e for execution every one second
# * * * * * for i in {1..60}; do /path/autologin.sh & sleep 1; done

#restart cron
#sudo service cron reload

DBG=true

[[ $DBG ]] && echo "Trying to access google"

status=$(curl google.com/generate_204 -I -s | head -n 1 | cut '-d ' '-f2')

[[ $DBG ]] && echo "Return status: ""${status}"

if [ "${status}" -eq "204" ]
then
  [[ $DBG ]] && echo OK
else
  [[ $DBG ]] && echo "Reading url from file"
  url=$(<url)

  [[ $DBG ]] && echo "Captive Portal - sending POST"
  curl \
  -d @query \
  "${url}" -v
fi