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
