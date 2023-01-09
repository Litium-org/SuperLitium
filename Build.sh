#!/bin/bash
## @author : Dyp1xy : https://github.com/DYPIXY
## @date   : 09/01/2023
## @TODO : add an build option for https lua 5.1, build folder and cache cleaning, pretty late rn, gonna sleep
# constants, fell free to change
readonly WORKING_DIRECTORY=$(pwd)
readonly TRY_GIT_PULL=false # try to git pull to update branch when building [Not recommended]
readonly GREEN='\033[0;32m' # Green output color
readonly YELLOW='\033[1;33m' # Yellow output color
readonly CYAN='\033[3;36m' # Cyan output color
readonly NC='\033[0m' # No Color
readonly GAME_BUILD_NAME="SuperLitium.love" # Compiled file name
BUILD_VERSION=$(cat ".litversion") # Engine version

# init/update submodules
if [ -d build/ ]
then
	rm -rdv build/
	mkdir build
	mkdir build/lua-https
else
	mkdir build
	mkdir build/lua-https
fi
# restart git submodules [ Dependencies ]
git submodule deinit -f .
git submodule update --init
## steps:
## 	Satisfy dependencies
## 	Update on run
## 	Build
# constructors

LUA_VERS=$(lua -v > build/lua_version | awk '{ print substr($2,1,3)}' build/lua_version)
LUA_HTTPS="/usr/lib64/lua/$LUA_VERS/"

# call yesno option
yesno() {
   	read -p "Do you wish to install anyway? [Y/n] " YN
    	case $YN in
        	[Yy]* ) return 0;;
        	[Nn]* ) return 1;;
		* ) echo "Please answer y or n."; yesno;;
	esac
}
# try to update if gitpull true
update(){
        if $TRY_GIT_PULL ; then
                git pull
        else
                echo -e "${GREEN}[$(date +"%H:%M")]:${NC} Not checking for updates"
        fi
}
# lua-https module compile (love)
lua-https() {
        echo -e "${GREEN}[$(date +"%H:%M")]:${NC} Building lua-https..."
        cd build/lua-https/
        #cmake error handling
        if cmake -Bbuild -S. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PWD\install ; then
        	echo -e "${GREEN}[$(date +"%H:%M")]:${NC} Cmake done"
        else
        	echo -e "${GREEN}[$(date +"%H:%M")]:${NC} Cmake error, quitting...."
        	cd $WORKING_DIRECTORY
        	rm -rd build/
        	exit
        fi
        cmake --build build --target install
        cd ..
	# Checks if already have an lua https on lib64, if not, copy builded files to lib64
        echo -e "${GREEN}[$(date +"%H:%M")]:${NC} sudo password needed to copy lib file to ${YELLOW}$LUA_HTTPS ${NC}and ${YELLOW}/usr/lib64/lua/5.1/ "
        if [ ! -d /usr/lib64/lua/5.1/ ] || [ ! -d $LUA_HTTPS ]
       	then
        	sudo mkdir /usr/lib64/lua/5.1/	
        	sudo mkdir $LUA_HTTPS
        fi
	# to general use        	
        if sudo cp "lua-httpsinstall/https.so" $LUA_HTTPS ; then 
  		echo -e "${GREEN}[$(date +"%H:%M")]:${NC} Copied [ https.so ] to $LUA_HTTPS ${YELLOW}(General use)"
  	else 
  		echo -e "${GREEN}[$(date +"%H:%M")]:${NC} No file copied to lib destination: $LUA_HTTPS"
  	fi
  	# to love use
        if sudo cp "lua-httpsinstall/https.so" "/usr/lib64/lua/5.1/" ; then 
        	echo -e "${GREEN}[$(date +"%H:%M")]:${NC} Copied [ https.so ] to /usr/lib64/lua/5.1/ ${YELLOW}(Love use)"
        else 
        	echo -e "${GREEN}[$(date +"%H:%M")]:${NC} No file copied to lib destination: /usr/lib64/lua/5.1/"
        fi
	
        echo -e "${GREEN}[$(date +"%H:%M")]:${NC} Module [ lua-https ] installed "
        cd $WORKING_DIRECTORY
        echo "lua-https = done" > libraries/instdep
	echo "Overridetest = done" > libraries/instdep
}

compile(){
	# create a release folder, just for the user, it`s on the gitignore
	if [ ! -d release ] then
		mkdir release
	fi
	cd release

        # exclude unnecessary files to build	build directories, build and boot scripts, and non necessary files
        TO_EXCLUDE="*.sh build/ *.md *.txt CHANGELOG *.cmd .gitignore .gitmodules .litversion .git *.love"
        zip -9 -x $TO_EXCLUDE -r SuperLitium.love .
        echo ""
        echo -e "${GREEN}[$(date +"%H:%M")]:${CYAN} SuperLitium.love ${NC}successfully build"
}

#func calls
if [ -s	 libraries/lua-https/done.txt ]
then
        echo -e "${GREEN}[$(date +"%H:%M")]:${NC} Module lua-htpps already installed"
        if yesno
	then
		lua-https
	fi
else
	lua-https
fi
update
compile
