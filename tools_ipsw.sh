#!/bin/bash
PURPLE="\033[1;35m"
RED="\033[0;32m"
ENDCOLOR="\033[0m"

echo -e "
\033[31m########################################################################################\033[m
                              $PURPLE"Support Ipswtools bash"$ENDCOLOR
\033[31m######################################################################################\033[m"
 

echo -e $RED" 
#################################################################################
 ████████╗ ██████╗  ██████╗ ██╗     ███████╗        ██╗██████╗ ███████╗██╗    ██╗
╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔════╝        ██║██╔══██╗██╔════╝██║    ██║
   ██║   ██║   ██║██║   ██║██║     ███████╗        ██║██████╔╝███████╗██║ █╗ ██║
   ██║   ██║   ██║██║   ██║██║     ╚════██║        ██║██╔═══╝ ╚════██║██║███╗██║
   ██║   ╚██████╔╝╚██████╔╝███████╗███████║███████╗██║██║     ███████║╚███╔███╔╝
   ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚══════╝╚══════╝╚═╝╚═╝     ╚══════╝ ╚══╝╚══╝ 
                                                                                



#################################################################################   "$ENDCOLOR                                                                                                  
echo -e "
\033[31m########################################################################################\033[m
                              $PURPLE"Credits To"$ENDCOLOR
\033[31m######################################################################################\033[m"
echo -e $RED"        Special thanks to test tools to have fun with ipsw Custom
                    
                         $PURPLE" created by Devjam81 "$ENDCOLOR 

"$ENDCOLOR

version="1000"


if [ $UID -ne 0 ]; then
    echo -e "\033[31This program must be run as root.This will probably fail.\033[m"
    sleep 3
    fi

###### Install script if not installed
if [ ! -e "/usr/bin/tools_ipsw" ];then
	echo "Script is not installed. Do you want to install it ? (Y/N)"
	read install
	if [[ $install = Y || $install = y ]] ; then
		cp -v $0 /usr/bin/tools_ipsw.sh
		chmod +x /usr/bin/tools_ipsw.sh
		#rm $0
		echo "Script should now be installed. Launching it !"
		sleep 3
		tools_ipsw
		exit 1
	else
		echo -e "\e[32m[-] Ok,maybe later !\e[0m"
	fi
else
	echo "Script is installed"
	sleep 1
fi
### End of install process

### Check for updates !
if [[ "$silent" = "1" ]];then
	echo "Not checking for a new version : silent mode."
else
	changelog=$(curl --silent -q https://raw.githubusercontent.com/Devjam81/tools_ipsw/master/changelog)
	last_version=$(curl --silent -q https://raw.githubusercontent.com/Devjam81/tools_ipsw/master/version) #store last version number to variable
	if [[ $last_version > $version ]];then # Comparing to current version
		echo -e "You are running version \033[31m$version\033[m, do you want to update to \033[32m$last_version\033[m? (Y/N)
Last changes are :
$changelog"
		read update
		if [[ $update = Y || $update = y ]];then
			echo "[+] Updating script..."
			wget -q https://github.com/Devjam81/tools_ipsw.git -O $0
			chmod +x $0
			echo "[-] Script updated !"
			if [[ $0 != '/usr/bin/yamas' && $ask_for_install = 'y' ]];then
				echo -e "Do you want to install it so that you can launch it with \"tools_ipsw\" ?"
				read install
				if [[ $install = Y || $install = y ]];then #do not proceed to install if using installed version : updating it already "installed" it over.
					cp $0 /usr/bin/tools_ipsw
					chmod +x /usr/bin/tools_ipsw
					echo "Script should now be installed, launching tools_ipsw !"
					sleep 3
					tools_ipsw
					exit 1
				else
					echo "Ok, continuing with updated version..."
					sleep 3
					$0
					exit 1
				fi
			fi
		
		sleep 2
		$0
		exit 1
		else
			echo "Ok, continuing with current version..."
		fi
	else
		echo "No update available"
	fi
fi
