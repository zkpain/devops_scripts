echo "Automation script to create Containers"
docker network create --attachable atnet
mkdir ~/postgresql && mkdir ~/postgresql_data
docker run -d --name sonardb --network atnet --restart always -e POSTGRES_USER=sonar -e POSTGRES_PASSWORD=sonar -v ~/postgresql:/var/lib/postgresql -v ~/postgresql_data:/var/lib/postgresql/data postgres:12.1-alpine
docker volume create sonarqube_data
docker volume create sonarqube_extensions
docker volume create sonarqube_logs
docker run -d --name sonarqube --network atnet -p 9000:9000 -e SONARQUBE_JDBC_URL=jdbc:postgresql://sonardb:5432/sonar -e SONAR_JDBC_USERNAME=sonar -e SONAR_JDBC_PASSWORD=sonar -v sonarqube_data:/opt/sonarqube/data -v sonarqube_extensions:/opt/sonarqube/extensions -v sonarqube_logs:/opt/sonarqube/logs sonarqube:8.9.0-community
docker volume create --name jenkins_home
docker run -d --name jenkins --network atnet -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts-jdk11
docker volume create --name nexus-data
docker run -d --name nexus --network atnet -p 8081:8081 -v nexus-data:/nexus-data sonatype/nexus3