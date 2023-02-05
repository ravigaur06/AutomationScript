#/bin/bash
echo "Please find below list of IP in your file."
cat my_server_info.txt | grep -E "\b[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\b"
