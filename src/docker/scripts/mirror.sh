#!/bin/sh

echo "Updating..."
java -Xmx1792m -jar /usr/local/bin/vulnz-6.1.2.jar cve --cache --directory /tmp/nvd
files=$(ls /tmp/nvd)
timestamp=$(date +%s)

for f in $files
do
  echo "/tmp/nvd/$f"
  if [ -f "/tmp/nvd/$f" ]; then
    if [ -d "/usr/local/apache2/htdocs/backup/" ]; then
      if [ ! -d "/usr/local/apache2/htdocs/backup/$timestamp" ]; then
        mkdir -p "/usr/local/apache2/htdocs/backup/$timestamp"
      fi
      if [ -f "/usr/local/apache2/htdocs/$f" ]; then
        mv "/usr/local/apache2/htdocs/$f" "/usr/local/apache2/htdocs/backup/$timestamp/"
      fi
    fi
    cp -f "/tmp/nvd/$f" "/usr/local/apache2/htdocs/$f"
  fi
done
