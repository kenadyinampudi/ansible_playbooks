#!/bin/ksh
if [ -s /var/adm/wtmp ]
then
/usr/sbin/acct/fwtmp < /var/adm/wtmp > dummy.wtmp
/usr/bin/tail -500 dummy.wtmp | /usr/sbin/acct/fwtmp -ic > /var/adm/wtmp
/usr/bin/rm dummy.wtmp
else
continue
fi
