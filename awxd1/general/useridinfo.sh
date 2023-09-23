IFS=$'\n'
for user in `awk 'BEGIN{FS=OFS=":"} {gsub(/\,/, "", $5)} {print $1 "," $5}' /etc/passwd`
do
   echo $user,$(hostname)
done
