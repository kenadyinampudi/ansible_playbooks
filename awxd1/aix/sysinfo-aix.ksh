#! /usr/bin/ksh
# To debug this script, uncomment next line
#set -x

DATE=`date +%m%d%y`

HN=`hostname`
BIN=/usr/bin
SBIN=/usr/sbin
IOS=/usr/ios/cli/ioscli
HACMD=/usr/es/sbin/cluster
GPFS=/usr/lpp/mmfs/bin
DIR=/usr/local/admin

TMP="/tmp"


#------------------------------------------------------------
# LOG file management
#
#
#if [ ! -d /root ]
#then
#   $BIN/mkdir -p /tmp/sysconfig
#   echo "System info. is collected in /tmp/sysconfig/sysconfig.$DATE.$HN file"
#   PERF_PATH=/tmp/sysconfig
#   LOGFILE="$PERF_PATH/sysconfig.$HN"
#else
#   echo "System info. is collected in /root/sysconfig.$DATE.$HN file"
#   PERF_PATH=/root
#   LOGFILE="/root/sysconfig.$HN"
#
#
#fi
#
#mv -f $LOGFILE.4 $LOGFILE.5
#mv -f $LOGFILE.3 $LOGFILE.4
#mv -f $LOGFILE.2 $LOGFILE.3
#mv -f $LOGFILE.1 $LOGFILE.2
#mv -f $LOGFILE $LOGFILE.1
#
#touch $LOGFILE
#chmod 666 $LOGFILE
#
#
#-------------------------------------------------------------
# For testing purpose only
#-------------------------------------------------------------
#LOGFILE=/tmp/sysconfig.$DATE.$HN
#touch $LOGFILE
#chmod 666 $LOGFILE
#-------------------------------------------------------------
#> ${LOGFILE}
#exec >> ${LOGFILE} 2>&1



# Put the server and the date in the report
echo " "
echo " "
echo " "
echo "VIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIO"
# First check this LPAR is VIOS or VIOC

lslpp -L | grep "ios.cli" > /dev/null 2>&1
if [[ $? != 0 ]]; then

        echo " "
        banner "LPAR/VIOC"
        echo "-------------      Hostname for this server is `uname -n`     -------------"
        echo " "
        echo " "
else
        print " "
        banner "VIO SVR"
        echo "-------------      Hostname for this server is `uname -n`     -------------"
        echo " "
        echo " "
        echo " "
        echo " "
        echo " "
        echo "                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
        echo "                            VIO Server Information   "
        echo "                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
        echo " "
        echo " "
        echo " "
        echo "============"
        echo " VIOS level "
        echo "============"
        echo " "
        $IOS ioslevel
        echo " "
        echo " "
        echo "=========="
        echo " DNS Info "
        echo "=========="
        echo " "
        $IOS cfgnamesrv -ls
        echo " "
        echo " "
        echo "==========="
        echo " Host Info "
        echo "==========="
        echo " "
        $IOS hostmap -ls
        echo " "
        echo " "
        echo "==================================="
        echo " Physical and Logical Adapter Info "
        echo "==================================="
        echo " "
        $IOS lsdev -type adapter
        echo " "
        echo " "
        echo "=============="
        echo " Routing Info "
        echo "=============="
        echo " "
        $IOS netstat -routinfo
        echo " "
        echo " "
        echo "==============="
        echo " Network state "
        echo "==============="
        echo " "
        $IOS netstat -state
        echo " "
        echo " "
        echo "========================"
        echo " Network parameter Info "
        echo "========================"
        echo " "
        $IOS optimizenet -list
        echo " "
        echo " "
        echo "========================"
        echo " Security-Allowed Ports "
        echo "========================"
        echo " "
        $IOS viosecure -firewall view
        echo " "
        echo " "
        echo "========================"
        echo " Security level Setting "
        echo "========================"
        echo " "
        $IOS viosecure -view -nonint
        echo " "
        echo " "
        echo "============"
        echo " lsmap -all "
        echo "============"
        echo " "
        $IOS lsmap -all
        echo " "
        echo " "
        echo "=================="
        echo " lsmap -all -npiv "
        echo "=================="
        echo " "
        $IOS lsmap -all -npiv
        echo " "
        echo " "
        echo "================="
        echo " lsmap -all -net "
        echo "================="
        echo " "
        $IOS lsmap -all -net
        echo " "
        echo " "
        echo "================================================"
        echo " Shared Storage Pool Info(if VIOS is 2.2 above) "
        echo "================================================"
        echo " "
        $IOS lscluster -d
        echo " "
        echo " "
fi
echo "VIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIOVIO"
echo " "
echo " "
echo " "
echo "HAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHA"
# Secondly, check this LPAR is Configured PowerHA or not

lslpp -L | grep "CSPOC" > /dev/null 2>&1
if [[ $? != 0 ]]; then

        echo " "
        banner "No HA"
        echo "-------------      Hostname for this server is `uname -n`     -------------"
        echo " "
        echo " "
else
        print " "
        banner "HA SVR"
        echo "-------------      Hostname for this server is `uname -n`     -------------"
        echo " "
        echo " "
        echo " "
        echo " "
        echo " "
        echo "                            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
        echo "                            PowerHA snapshot Information "
        echo "                            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
        echo " "
        echo " "
        echo " "
        echo "===================="
        echo " Running clsnapshot "
        echo "===================="
        echo " "
        $HACMD/utilities/clsnapshot
        echo " "
        echo " "
        echo "==============="
        echo " snapshot info "
        echo "==============="
        echo " "
        cat $HACMD/snapshots *.info
        echo " "
        echo " "
        echo "=============="
        echo " snapshot odm "
        echo "=============="
        echo " "
        cat $HACMD/snapshots *.odm
        echo " "
        echo " "
        echo "=============="
        echo " lssrc -s clinfoES "
        echo "=============="
        lssrc -s clinfoES
        echo " "
        echo " "
        echo "=============="
        echo " lssrc -ls clstrmgrES "
        echo "=============="
        lssrc -ls clstrmgrES
        echo " "
        echo " "
        echo "=============="
        echo " clRGinfo "
        echo "=============="
        $HACMD/utilities/clRGinfo
        echo " "
        echo " "
        echo "=============="
        echo " cllsclstr "
        echo "=============="
        $HACMD/utilities/cllsclstr
        echo " "
        echo " "
        echo "=============="
        echo " cllscf "
        echo "=============="
        $HACMD/utilities/cllscf
        echo " "
        echo " "
        echo "=============="
        echo " cllsfs "
        echo "=============="
        $HACMD/utilities/cllsfs
        echo " "
        echo " "
        echo " cllsvg "
        echo "=============="
        $HACMD/utilities/cllsvg
        echo "=============="
        echo " "
        echo " "
fi
echo "HAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHA"

echo " "
echo " "
echo " "
echo "GPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFS"
# Thirdly, check this LPAR is Configured with GPFS or not

lslpp -L | grep "gpfs" > /dev/null 2>&1
if [[ $? != 0 ]]; then

        echo " "
        banner "No GPFS"
        echo "-------------      Hostname for this server is `uname -n`     -------------"
        echo " "
        echo " "
else
        print " "
        banner "GPFS SVR"
        echo "-------------      Hostname for this server is `uname -n`     -------------"
        echo " "
        echo " "
        echo " "
        echo " "
        echo " "
        echo "                            %%%%%%%%%%%%%%%%%%%%%%%%%"
        echo "                            GPFS Cluster Information "
        echo "                            %%%%%%%%%%%%%%%%%%%%%%%%%"
        echo " "
        echo " "
        echo " "
        echo "=============="
        echo " Cluster Info "
        echo "=============="
        echo " "
        $GPFS/mmlscluster
        echo " "
        echo " "
        echo "=============="
        echo " License info "
        echo "=============="
        echo " "
        $GPFS/mmlslicense
        echo " "
        echo " "
        echo "=========="
        echo " NSD Info "
        echo "=========="
        echo " "
        $GPFS/mmlsnsd
        echo " "
        echo " "
        echo "============="
        echo " GPFS Status "
        echo "============="
        echo " "
        $GPFS/mmgetstate -aLs
        echo " "
        echo " "
        echo "============="
        echo " GPFS mmlsconfig "
        echo "============="
        echo " "
        $GPFS/mmlsconfig
        echo " "
        echo " "
        echo "============="
        echo " GPFS mmgetstate -a "
        echo "============="
        echo " "
        $GPFS/mmgetstate -a
        echo " "
        echo " "
        echo "============="
        echo " GPFS mmgetstate -a "
        echo "============="
        echo " "
        $GPFS/mmlsmgr -c
        echo " "
        echo " "
        echo "============="
        echo " GPFS mmlsfs all"
        echo "============="
        echo " "
        $GPFS/mmlsfs all
        echo " "
        echo " "
        echo "============="
        echo " GPFS mmlsmount all "
        echo "============="
        echo " "
        $GPFS/mmlsmount all
        echo " "
        echo " "
        echo "============="
        echo " GPFS ps -ef|grep gpfs "
        echo "============="
        echo " "
        ps -ef|grep -i gpfs
        echo " "
        echo " "
fi
echo "GPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFSGPFS"


echo " "
echo " "
echo " "
echo "                            %%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "                            System Configuration Report"
echo "                            %%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo " "
echo " "
echo `date `
echo " "
echo " "
echo "==========================================="
echo "<< `uname -n` -- Hardware Model and Type >>"
echo "==========================================="
echo " "
echo " "
echo "(( System Model ))"
uname -M
echo " "
echo "(( Machine ID ))"
uname -m
echo " "
echo "(( System ID ))"
uname -u
echo " "
echo "(( All information ))"
uname -au
echo " "
echo " "
echo " "
echo " "

echo "========================================"
echo "<< `uname -n` -- Firmware Information >>"
echo "========================================"
echo " "
echo "----------"
echo "lsmcode -c"
echo "----------"
echo " "
$SBIN/lsmcode -c
echo " "
echo " "
echo " "
echo "=================================="
echo "<< `uname -n` -- prtconf output >>"
echo "=================================="
echo " "
echo " "
$SBIN/prtconf
echo " "
echo " "
echo " "

# General OS Information.
echo "#########################################################################"
echo " "
echo " General OS Information "
echo " "
echo "#########################################################################"
echo " "
echo " "
echo " "
# Check the Operating System Level in the report
echo "=============================================="
echo "<< `uname -n` -- AIX Operating System Level >>"
echo "=============================================="
echo " "
echo "-----------------"
echo "Current AIX Level"
echo "-----------------"
echo " "
echo " "
$BIN/oslevel -s
echo " "
echo "----------------"
echo "Current ML Level"
echo "----------------"
echo " "
echo " "
$SBIN/instfix -i | grep ML
echo " "
echo "---------------------------------------"
echo "Lists names of known maintenance levels"
echo "---------------------------------------"
echo " "
$BIN/oslevel -q
echo " "
echo " "
echo "-----------------------------------------------------------------"
echo "Lists filesets at levels later than the current maintenance level"
echo "-----------------------------------------------------------------"
echo " "
$BIN/oslevel -g
echo " "
echo " "
echo " "
echo " "

echo "===================================="
echo "<< `uname -n` -- Boot Information >>"
echo "===================================="
echo " "
echo "--------------------"
echo "The last boot device"
echo "--------------------"
echo " "
$SBIN/bootinfo -b
echo " "
echo " "
echo "---------------------------------------------"
echo "Show what this machine can run: 32 or 64 bits"
echo "---------------------------------------------"
echo " "
$SBIN/bootinfo -y
echo " "
echo " "
echo "---------------------------------------------------------"
echo "Show what kernel you are currently running: 32 or 64 bits"
echo "---------------------------------------------------------"
echo " "
$SBIN/bootinfo -K
echo " "
echo " "
echo "---------------------------------"
echo "The list of boot device (normal) "
echo "---------------------------------"
echo " "
$BIN/bootlist -m normal -o
echo " "
echo " "
echo "----------------------------------"
echo "The list of boot device (service) "
echo "----------------------------------"
echo " "
$BIN/bootlist -m service -o
echo " "
echo " "
echo " "
echo " "

# Print the number of CPUs on this server
echo "======================================"
echo "<< `uname -n` -- CPU information >>"
echo "======================================"
echo " "
echo "------------------"
echo "The number of CPUs"
echo "------------------"
echo " "
$SBIN/lsdev -Cc processor
echo " "
echo " "
$SBIN/lscfg|grep proc|awk '{print $2}'|while read PROC
do
echo $PROC
$SBIN/lsattr -El $PROC
done
echo " "
echo " "
echo " "
echo " "

# Print the amount of memory on this server
echo "======================================"
echo "<< `uname -n` -- Memory information >>"
echo "======================================"
echo " "
echo "-----------------------"
echo "The Size of real memory"
echo "-----------------------"
echo " "
lsattr -E -H -l mem0
echo " "
echo " "
echo "-----------------------"
echo "The Size of L2 Cache"
echo "-----------------------"
echo " "
lsattr -E -H -l L2cache0
echo " "
echo " "
echo " "
echo " "
# List all vital product information
echo "============================================="
echo "<< `uname -n` -- Vital Product information >>"
echo "============================================="
echo " "
echo " "
lscfg -pv
echo " "
echo " "
echo " "
echo " "

# List all devices in customized ODM database
echo "=============================================================="
echo "<< `uname -n` -- Listing devices in customized ODM database >>"
echo "=============================================================="
echo " "
lsdev -C -H
echo " "
echo " "
echo "======================================================================"
echo "<< `uname -n` -- Listing devices in Available state in ODM database >>"
echo "======================================================================"
echo " "
lsdev -C -c adapter -S a
echo " "
echo " "
echo " "

# Print physical FCS adapter and disk info
echo "======================================================"
echo "<< `uname -n` -- FCS adapter and physical disk info >>"
echo "======================================================"
echo " "
lscfg | grep -i fcs | grep -i adapter
echo " "
echo " "
lsdev -Ccadapter | grep fcs | awk '{print$1}' | while read ENDEV
do
        echo "<< Vital Product Information for FC Adapter: $ENDEV >>"
        lscfg -vl $ENDEV
        echo " "
        echo " "
done
echo " "
echo " "
lsdev -Cc disk
echo " "
echo " "
echo " "
echo " "


# Put the machinetype info in the report
echo "=============================================="
echo "<< `uname -n` -- System Information (lscfg) >>"
echo "=============================================="
echo " "
lscfg
echo " "
echo " "
echo " "
echo " "

echo "=============================================="
echo "<< `uname -n` -- System Information (lsslot) >>"
echo "=============================================="
echo " "
lsslot -c pci
echo " "
echo " "
echo " "
echo " "

# Put the OS-dump info in the report
echo "===================================="
echo "<< `uname -n` -- DUMP information >>"
echo "===================================="
echo " "
echo "---------------------------------"
echo "Statistical Info from recent Dump"
echo "---------------------------------"
echo " "
$BIN/sysdumpdev -L
echo " "
echo " "
echo " "
echo "-------------------"
echo "Current Dump Device"
echo "-------------------"
echo " "
$BIN/sysdumpdev -l
echo " "
echo " "
echo "-------------------"
echo "Estimated Dump Size"
echo "-------------------"
echo " "
$BIN/sysdumpdev -e
echo " "
echo " "
echo " "
echo " "

# Put the OS-page space info in the report
echo "============================================="
echo "<< `uname -n` --  Paging space information >>"
echo "============================================="
echo " "
/$SBIN/lsps -a -c
echo " "
echo " "
/$SBIN/lsps -a
echo " "
echo " "

echo "========================================= "
echo "<< `uname -n` -- Disk Usage Information>>"
echo "========================================= "
echo " "
$BIN/df -k
echo " "
echo " "
echo " "
echo " "

echo "==================================="
echo "<< `uname -n` -- TTY Information >>"
echo "==================================="
echo " "
/$SBIN/lsdev -Cc tty
echo " "
echo " "
echo " "
echo " "

echo "================================================= "
echo "<< `uname -n` -- File System export Information>> "
echo "================================================= "
echo " "
echo " "
$SBIN/exportfs
echo " "
echo " "
echo " "
echo " "

echo "=================================== "
echo "<< `uname -n` -- Path Information>> "
echo "=================================== "
echo " "
echo " "
$SBIN/lspath
echo " "
echo " "
echo " "
echo " "
# Find all the disks in the machine then print info
echo "#########################################################################"
echo " "
echo " Storage Information "
echo " "
echo "#########################################################################"
echo " "
echo " "
echo " "
# EMC & Hitachi Storage Information
echo "##############################"
echo " "
echo " Hitachi Storage Information "
echo " "
echo "##############################"
echo " "
echo " "
echo " "
lsdev -C | grep dlm >/dev/null
if [ $? = 0 ]
then
        echo "================================== "
        echo "<< `uname -n` -- Hitachi Drives >> "
        echo "================================== "
        /usr/D*/bin/dlnkmgr view -drv
        echo " "
        echo " "
        echo "========================================== "
        echo "<< `uname -n` -- Hitachi Drives details >> "
        echo "========================================== "
        /usr/D*/bin/dlnkmgr view -lu -item
        echo " "
        echo " "
        echo "======================================== "
        echo "<< `uname -n` -- Hitachi Path details >> "
        echo "======================================== "
        /usr/D*/bin/dlnkmgr view -path
        echo " "
        echo " "
fi
echo " "
echo " "
echo " "
echo "##########################"
echo " "
echo " EMC Storage Information "
echo " "
echo "##########################"
echo " "
echo " "
echo " "
$SBIN/lspv|grep power>/dev/null
if [ $? = 0 ]
then
        echo "====================================== "
        echo "<< `uname -n` -- EMC Drives details >> "
        echo "====================================== "
        $SBIN/powermt display
        echo " "
        echo " "
        $SBIN/powermt display dev=all
        echo " "
        echo " "
        $SBIN/inq|head -9
        echo " "
        echo " "
        $SBIN/inq|grep power
        echo " "
        echo " "
fi
echo " "
echo " "
echo " "

# List all VG

# LVM Information.
echo "#########################################################################"
echo " "
echo " LVM Information "
echo " "
echo "#########################################################################"
echo " "
echo " "
echo " "
# List all VG
# Find all the disks in the machine then print info
echo "====================================== "
echo "<< `uname -n` -- Summary of Storage >> "
echo "====================================== "
echo " "
echo "-------------"
echo "Volume Groups"
echo "-------------"
lsvg
echo " "
echo " "
echo "----------------------"
echo "Volume Groups (Active)"
echo "----------------------"
lsvg -o
echo " "
echo " "
echo "----------------"
echo "Physical Volumes"
echo "----------------"
lspv
echo " "
echo " "
echo " "
echo " "
lspv | grep hdisk | awk '{print$1}' | while read HDSK
do
        echo "<< Size in MB for $HDSK >>"
        bootinfo -s $HDSK
done
echo " "
echo " "
echo " "
echo " "

echo "=============================================== "
echo "<< `uname -n` -- Free space on volume groups >> "
echo "=============================================== "
echo " "
echo " "
$SBIN/lsvg -o|while read VG
do
echo $VG
$SBIN/lsvg $VG|grep FREE|awk '{print $4,$5,$6,$7,$8}'
echo
done
echo " "
echo " "
echo " "

echo "========================================== "
echo "<< `uname -n` -- List all volume groups >> "
echo "========================================== "
echo " "
echo " "

lsvg | while read VG
do
        echo " "
        echo "The following physical volumes are in Volume Group -- $VG --"
        lsvg -p $VG
        echo " "
        echo "<< Volume group info for $VG >>"
        lsvg $VG
        echo " "
        echo " "
done

echo " "
echo " "
echo " "
echo " "

# List physical disk info
echo "============================================================= "
echo "<< `uname -n` -- List all physical volumes by volume group >> "
echo "============================================================= "
echo " "
getlvodm -C | while read VOL
do
        echo " "
        echo "<< Physical volume info for $VOL by PVID >>"
        lspv $VOL
        echo " "
        echo "<< Physical volume info for $VOL by logical volume >>"
        lspv -l $VOL
        echo " "
        echo "<< Physical volume info for $VOL by PP Range >>"
        lspv -p $VOL
        echo " "
        echo " "
done

echo " "

# List all logical volumes by volume group
echo "============================================================ "
echo "<< `uname -n` -- List all logical volumes by volume group >> "
echo "============================================================ "
echo " "
lsvg -o | while read VG
do
        echo "<< List of logical volumes defined in volume group $VG >>"
        lsvg -l $VG
        echo " "
        echo "<< List of physical volumes defined in volume group $VG >>"
        lsvg -p $VG
        echo " "
        echo " "
done

# List all logical volume information
echo " "
echo "================================================================ "
echo "<< `uname -n` -- List all Logical Volume Attribute Information >>"
echo "================================================================ "
echo " "
lsdev -C | grep "Logical volume" | awk '{print$1}' | while read LVNAME
do
        echo "<< Statistic for Logical Volume: $LVNAME >>"
        lslv $LVNAME
        echo " "
        echo " "
        lslv -l $LVNAME
        echo " "
        echo " "
done
echo " "
echo " "
echo " "
echo " "

echo " "
# Save the mount information in the report
echo "====================================== "
echo "<< `uname -n ` -- Mount information >>"
echo "====================================== "
echo " "
mount
echo " "
echo " "
echo " "
echo " "

echo "========================================== "
echo "<< `uname -n ` -- showmount information >> "
echo "========================================== "
echo " "
$BIN/showmount -a
echo " "
echo " "
echo " "
echo " "

# Print the file system information
echo "========================================= "
echo "<< `uname -n` -- List all file systems >>"
echo "========================================= "
echo " "
lsfs -l
echo " "
echo " "
echo " "
echo " "

# Print the network file system information
echo "============================================================= "
echo "<< `uname -n` -- List all network file systems(NFS) mounted >>"
echo "============================================================= "
echo " "
$SBIN/lsnfsmnt
echo " "
echo " "
echo " "
echo " "

# Network Information.
echo "#########################################################################"
echo " "
echo " Network Information "
echo " "
echo "#########################################################################"
echo " "
echo " "
# Check Network Option
echo "============================================= "
echo "<< `uname -n` -- Network Adapter configured >>"
echo "============================================= "
echo " "
echo "-----------"
echo "ifconfig -a"
echo "-----------"
$SBIN/ifconfig -a
echo " "
echo " "
echo " "
echo " "
echo "=============================================================== "
echo "<< `uname -n` -- Active Network Adapter Attribute Information >>"
echo "=============================================================== "
echo " "
$BIN/netstat -i|tail +2|cut -d" " -f1| while read IF
do
if [ $IF != "lo0" ]
then
        if [ "$PIF" != "$IF" ]
        then
                /etc/ifconfig $IF
                echo " "
                $SBIN/lsattr -El $IF
                echo " "
                PIF=$IF
        fi
fi
done
echo "============================================================ "
echo "<< `uname -n` -- All Network Adapter Attribute Information >>"
echo "============================================================ "
echo " "
lsdev -Ccadapter | grep ent | awk '{print$1}' | while read ENDEV
do
        echo "<< Statistic for Ethernet Adapter: $ENDEV >>"
        lsattr -E -H -l $ENDEV
        echo " "
        echo " "
done
echo " "
echo " "
echo " "
echo " "

# Put the network information in the report
echo "================================================="
echo "<< `uname -n` -- Network information (netstat) >>"
echo "================================================="
echo " "
echo " "
echo "-----------"
echo "netstat -nr"
echo "-----------"
netstat -nr
echo " "
echo " "
echo "-----------"
echo "netstat -i"
echo "-----------"
netstat -in
echo " "
echo " "
echo "-----------"
echo "netstat -m"
echo "-----------"
netstat -m
echo " "
echo " "
echo "-----------"
echo "netstat -v"
echo "-----------"
netstat -v
echo " "
echo " "
echo " "
echo " "

# Put the Ehernet Adapter information in the report
echo "========================================================"
echo "<< `uname -n` -- Ethernet Adapter Information (lsdev) >>"
echo "========================================================"
echo " "
lsdev -Ccadapter | grep ent
echo " "
echo " "
echo " "
echo " "

echo "=========================================================="
echo "<< `uname -n` -- Ethernet Adapter Statistics (entstat) >>"
echo "=========================================================="
echo " "
lsdev -Ccadapter | grep ent | awk '{print$1}' | while read ENDEV
do
        echo "<< Statistics for Ethernet Adapter: $ENDEV >>"
        $SBIN/entstat -d $ENDEV
        echo " "
        echo " "
done
echo " "
echo " "
echo " "

echo "==========================================="
echo "<< `uname -n` -- NIM Information (lsnim) >>"
echo "==========================================="
echo " "
lsnim -l
echo " "
echo " "
echo " "
echo "#########################################################################"
echo " "
echo " ERROR Report Information "
echo " "
echo "#########################################################################"
echo " "
echo " "
echo " "
errpt -d H,U,S -T TEMP,PEND,PERM,UNKN|head -2000
errpt -a -d H,U,S -T TEMP,PEND,PERM,UNKN|head -2000
echo " "
echo " "
echo " "
echo " "

# Important Files.
echo "#########################################################################"
echo " "
echo " Important Files Information "
echo " "
echo "#########################################################################"
echo " "
echo " "
echo " "
echo "======================================= "
echo "<< `uname -n` -- Some Important files>> "
echo "======================================= "
echo " "
echo "------------"
echo ".profile"
echo "------------"
cat $HOME/.profile
echo " "
echo " "
echo "------------"
echo ".rhosts"
echo "------------"
cat $HOME/.rhosts
echo " "
echo " "
echo "-----------"
echo "/etc/inittab"
echo "-----------"
cat /etc/inittab
echo " "
echo " "
echo "---------------"
echo "/etc/inetd.conf"
echo "---------------"
cat /etc/inetd.conf
echo " "
echo " "
echo "-----------"
echo "/etc/hosts"
echo "-----------"
cat /etc/hosts
echo " "
echo " "
echo "----------------"
echo "/etc/resolv.conf"
echo "----------------"
cat /etc/resolv.conf
echo " "
echo " "
echo "----------------"
echo "/etc/netsvc.conf"
echo "----------------"
cat /etc/netsvc.conf
echo " "
echo " "
echo "-----------"
echo "/etc/motd"
echo "-----------"
cat /etc/motd
echo " "
echo " "
echo "-----------"
echo "/etc/passwd"
echo "-----------"
cat /etc/passwd
echo " "
echo " "
echo "-----------"
echo "/etc/group"
echo "-----------"
cat /etc/group
echo " "
echo " "
echo "-------------"
echo "/etc/bootptab"
echo "-------------"
cat /etc/bootptab
echo " "
echo " "
echo "-------------"
echo "/etc/niminfo "
echo "-------------"
cat /etc/niminfo
echo " "
echo " "
echo "------------"
echo "/etc/profile"
echo "------------"
cat /etc/profile
echo " "
echo " "
echo "------------------"
echo "/etc/security/user"
echo "------------------"
cat /etc/security/user
echo " "
echo " "
echo "--------------------"
echo "/etc/security/limits"
echo "--------------------"
cat /etc/security/limits
echo " "
echo " "
echo "-----------------------"
echo "/etc/security/login.cfg"
echo "-----------------------"
cat /etc/security/login.cfg
echo " "
echo " "
echo "---------------------"
echo "/etc/security/environ"
echo "---------------------"
cat /etc/security/environ
echo " "
echo " "
echo "-------------"
echo "/etc/services"
echo "-------------"
cat /etc/services
echo " "
echo " "
echo "----------------"
echo "/etc/filesystems"
echo "----------------"
cat /etc/filesystems
echo " "
echo " "
echo "-----------"
echo "/etc/rc.net"
echo "-----------"
cat /etc/rc.net
echo " "
echo " "
echo "----------------------"
echo "/etc/tunables/lastboot"
echo "----------------------"
cat /etc/tunables/lastboot
echo " "
echo " "
echo "----------------------"
echo "/etc/tunables/nextboot"
echo "----------------------"
cat /etc/tunables/nextboot
echo " "
echo " "
echo "-------------"
echo "/bosinst.data"
echo "-------------"
cat /bosinst.data
echo " "
echo " "
echo "-----------"
echo "/image.data"
echo "-----------"
cat /image.data
echo " "
echo " "
echo " "
echo " "


# List Software Installed.
echo "#########################################################################"
echo " "
echo " Software Information "
echo " "
echo "#########################################################################"
echo " "
echo " "
echo " "
# Verify that all filesets have all required requisites
echo "============================= "
echo "<< `uname -n` -- lppchk -v >> "
echo "============================= "
echo " "
$BIN/lppchk -v
echo " "
echo " "
echo "<< Note that it is GOOD if nothing returned ! >> "
echo " "
echo " "

# Get the LPP information
echo "=================================================== "
echo "<< `uname -n` -- List the history of PTF applied >> "
echo "=================================================== "
echo " "
lslpp -h
echo " "
echo " "
echo " "
echo " "
echo " "
echo "=========================================================== "
echo "<< `uname -n` -- List all LPPs installed on this machine >> "
echo "=========================================================== "
lslpp -L all
echo " "
echo " "
echo " "
echo " "

# Other Useful Information
#
echo "#########################################################################"
echo " "
echo " Other Useful Information "
echo " "
echo "#########################################################################"
echo " "
echo " "
echo " "
echo "=========================== "
echo "<< `uname -n` -- Up time >> "
echo "=========================== "
echo " "
echo " "
$BIN/uptime
echo " "
echo " "
echo " "
echo " "
echo "============================================ "
echo "<< `uname -n` -- Check root's Environment >> "
echo "============================================ "
echo " "
echo " "
echo "---"
echo "env"
echo "---"
echo " "
$BIN/env
echo " "
echo " "
echo " "
echo " "
echo "========================================= "
echo "<< `uname -n` -- Who is on the system? >> "
echo "========================================= "
echo " "
echo " "
echo "-"
echo "w"
echo "-"
echo " "
$BIN/w
echo " "
echo " "
echo "---"
echo "who"
echo "---"
echo " "
$BIN/who
echo " "
echo " "
echo "------"
echo "who -r"
echo "------"
echo " "
$BIN/who -r
echo " "
echo " "
echo "------"
echo "who -p               "
echo "------"
echo " "
$BIN/who -p
echo " "
echo " "
echo " "
echo " "

echo "============================================================== "
echo "<< `uname -n` -- System Resource Controller(SRC) Information>> "
echo "============================================================== "
echo " "
echo " "
$BIN/lssrc -a
echo " "
echo " "
echo " "
echo " "

echo "====================================== "
echo "<< `uname -n` -- Crontab Information>> "
echo "====================================== "
echo " "
echo " "
crontab -l
echo " "
echo " "
echo " "
echo " "

echo "======================================== "
echo "<< `uname -n` -- Alog Boot Information>> "
echo "======================================== "
echo " "
echo " "
alog -o -f /var/adm/ras/bootlog
echo " "
echo " "
echo " "
echo " "

echo "=========================================== "
echo "<< `uname -n` -- User License Information>> "
echo "=========================================== "
echo " "
echo " "
lslicense
echo " "
echo " "
echo " "
echo " "

echo "============================================ "
echo "<< `uname -n` -- Printer Queue Information>> "
echo "============================================ "
echo " "
echo " "
lpstat -t
echo " "
echo " "
echo "============================================== "
echo "<< `uname -n` -- Inventory Scout Information>> "
echo "============================================== "
echo " "
echo " "
invscout -r
echo " "
echo " "
echo " "
echo " "
echo " "
echo "                            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "                            System Performance Information"
echo "                            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo " "
echo " "
echo `date `
echo " "
echo " "

echo "=================================================================="
echo "<< `uname -n` -- Information about the partition  (lparstat -i) >>"
echo "=================================================================="
echo " "
lparstat -i
echo " "
echo " "
echo " "
echo " "

# Put the system attributes in the report
echo "======================================================================="
echo "<< `uname -n` -- System Attribute information (lsattr -E -H -l sys0) >>"
echo "======================================================================="
echo " "
lsattr -E -H -l sys0
echo " "
echo " "
echo " "
echo " "
echo "===================================================================="
echo "<< `uname -n` -- AIO Attribute information (lsattr -E -H -l aio0) >>"
echo "===================================================================="
echo " "
lsattr -E -H -l aio0
echo " "
echo " "
echo " "
echo " "
echo "======================================================================"
echo "<< `uname -n` -- INET Attribute information (lsattr -E -H -l inet0) >>"
echo "======================================================================"
echo " "
lsattr -E -H -l inet0
echo " "
echo " "
echo " "
echo " "

echo "============================================="
echo "<< `uname -n` -- Memory Tuning Information >>"
echo "============================================="
echo " "
echo "---------------------------"
echo "/usr/samples/kernel/vmtune "
echo "---------------------------"
echo " "
/usr/samples/kernel/vmtune
echo " "
echo " "
echo " "
echo " "
echo "----------------"
echo "$SBIN/vmo -a"
echo "----------------"
echo " "
$SBIN/vmo -a
echo " "
echo " "
echo "----------------"
echo "$SBIN/vmo -L"
echo "----------------"
echo " "
$SBIN/vmo -L
echo " "
echo " "
echo "----------------"
echo "$SBIN/ioo -a"
echo "----------------"
echo " "
$SBIN/ioo -a
echo " "
echo " "
echo "----------------"
echo "$SBIN/ioo -L"
echo "----------------"
echo " "
$SBIN/ioo -L
echo " "
echo " "
echo " "
echo " "

echo "=========================================="
echo "<< `uname -n` -- cpu Tuning Information >>"
echo "=========================================="
echo " "
echo "------------------------------"
echo "/usr/samples/kernel/schedtune "
echo "------------------------------"
echo " "
/usr/samples/kernel/schedtune
echo " "
echo " "
echo " "
echo " "
echo "-------------------"
echo "$SBIN/schedo -a"
echo "-------------------"
echo " "
$SBIN/schedo -a
echo " "
echo " "
echo " "
echo " "

echo "================================================= "
echo "<< `uname -n` -- Network Option Tunable Values >>"
echo "================================================= "
echo " "
echo "-------------------------------"
echo "Important Network Option Values"
echo "-------------------------------"
echo " "
no -a | grep thewall
no -a | grep sb_max
no -a | grep tcp_sendspace
no -a | grep tcp_recvspace
no -a | grep udp_sendspace
no -a | grep udp_recvspace
no -a | grep rfc1323
no -a | grep tcp_mssdflt
no -a | grep ipforwarding
echo " "
echo "---------------------------------"
echo "All Network Option Values (no -a)"
echo "---------------------------------"
echo " "
no -a
echo " "
echo " "
echo " "
echo " "
echo "-----------------------------------------------"
echo "All Network File System Option Values (nfso -a)"
echo "-----------------------------------------------"
echo " "
nfso -a
echo " "
echo " "

echo " "
echo " "
echo " "
echo "                         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "                         System Performance Data Collection"
echo "                         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo " "
echo " "
echo `date `
echo " "
echo " "

echo "========================= "
echo "<< `uname -n` -- vmstat >>"
echo "========================= "
echo " "
$BIN/vmstat -s
echo " "
echo " "
$BIN/vmstat -It 2 5
echo " "
echo " "
$BIN/vmstat -s
echo " "
echo " "

echo "========================= "
echo "<< `uname -n` -- iostat >>"
echo "========================= "
echo " "
$BIN/iostat -s
echo " "
echo " "
$BIN/iostat -a 2 5
echo " "
echo " "
$BIN/iostat -s
echo " "
echo " "
echo "==============================================================================="
echo "<< `uname -n` -- Summary of LPAR statistics on P-HYP  (lparstat -h 2 5) >>"
echo "==============================================================================="
echo " "
lparstat -h 2 5
echo " "
echo " "
echo " "
echo " "
echo "================================================================"
echo "<< `uname -n` -- Detailed P-HYP statistics  (lparstat -H 2 5) >>"
echo "================================================================"
echo " "
lparstat -H 2 5
echo " "
echo " "
echo " "
echo " "
echo "================================================================================="
echo "<< `uname -n` -- Statistics for Shared memory pool and I/O Mem  (lparstat -m ) >>"
echo "================================================================================="
echo " "
lparstat -m
echo " "
echo " "
echo " "
echo " "
echo "===================================================================================="
echo "<< `uname -n` -- Display perf statistics for all logical procs  (mpstat -a 2 5  ) >>"
echo "===================================================================================="
echo " "
mpstat -a 2 5
echo " "
echo " "
echo " "
echo " "

echo `date `
echo "<< End of the Document for `uname -n` >>"
# End of the Script
