#Tested on ubutnu 20.04 (2020-02)
#Should work on any debian distrobution

sudo apt-get update

#Java JDK 11 , gcc, git, flex, bison, unzip (for unzipping .zip files)
sudo apt install curl openjdk-11-jdk gcc git unzip zip g++ make

#Eclipse
sudo snap install eclipse --classic

#Gradle
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install gradle 5.0

#sudo apt install flex bison


#dex2jar
#wget -c --no-clobber https://github.com/pxb1988/dex2jar/releases/download/2.0/dex-tools-2.0.zip 
#unzip dex-tools-2.0.zip

#AXMLPrinter2 
#wget -c --no-clobber https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/android4me/AXMLPrinter2.jar

#HFS Explorer version 23.1 (newer than 21)
#wget -c --no-clobber https://github.com/unsound/hfsexplorer/releases/download/hfsexplorer-0.23.1/hfsexplorer-0.23.1-bin.zip

#Yet Another Java Service Wrapper 12.12
#wget -c --no-clobber https://sourceforge.net/projects/yajsw/files/yajsw/yajsw-stable-12.12/yajsw-stable-12.12.zip/download

#Eclipse PDE

#Eclipse CDT

#PyDev

#Ghidra
folder="ghidra"
url="https://github.com/NationalSecurityAgency/ghidra"
if ! git clone "${url}" "${folder}" 2>/dev/null && [ -d "${folder}" ] ; then
    echo "Clone failed because the folder ${folder} exists"
fi

#Build Ghidra
gradle --init-script $folder/gradle/support/fetchDependencies.gradle init
cd $folder
gradle buildGhidra
gradle eclipse
gradle buildNatives_linux64
gradle sleighCompile
gradle eclipse -PeclipsePDE
gradle prepDev

#Unzip build
cd build/dist/
unzip *

#Print location
dir=$(ls -d */)
cd $dir
echo "



===============================
===============================
===============================
Ghidra is located at:
"
pwd
echo "
===============================
===============================
===============================



"



