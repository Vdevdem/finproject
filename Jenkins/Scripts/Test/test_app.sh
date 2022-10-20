#Get packages
sudo apt-get update -y
sudo apt-get upgrade -y

#Remove existing repo
sudo rm -r spring-petclinic-rest

#Clone into repo
git clone https://github.com/Vdevdem/spring-petclinic-rest

#Enter directory
cd spring-petclinic-rest

#Install Java, OpenJDK, Maven
sudo apt install openjdk-8-jre maven default-jre -y

#Run tests
mvn test
