#!/bin/bash

LOG_FILE="log/system.log"
ABOUT_FILE="log/about.log"
RUTH_FILE="log/ruth.log"

LOG_FILES=("$LOG_FILE" "$ABOUT_FILE" "$RUTH_FILE")

ERROR_PATTERN=("ERROR" "INFO" "WARNING")
if [ ! -f log/system.log ]; then
echo "file does not exist"
exit 1
fi 

echo -e "\n-------ANALYZING LOG--------"
echo "USER: $(whoami)"
echo "DATE: $(date)"
echo "UPTIME: $(uptime)"


for file in "${LOG_FILES[@]}"; 
do
 echo -e "\n---------ANALYZING: $file------"
for pattern in "${ERROR_PATTERN[@]}"; do
 echo -e "\n-----$pattern COUNT-----"
grep -c "$pattern" "$file"

echo "----$pattern DETAILS-----"
grep "$pattern" "$file" | sort | uniq
 done
done


echo -e "\n------DISK FILE------"
df -h | tail -3
echo -e "\n------LARGE FILE------"
find . -type f -name "*.log" -size +1k
echo -e "\n-----UPLOADED FILE IN THE LAST 20 DAYS-----"
find . -name "*.log" -mtime -10
echo -e "\n--------PROCESSING UNIT------"
ps aux | sort -nrk 3 | tail -3
count=$(grep "ERROR" $LOG_FILES | wc -l)
if [ $count -gt 0 ]
then
 echo "there are errors in the system"
else
 echo "system is clean"
 fi

echo -e "\n--------ANALYSIS COMPLETED------"