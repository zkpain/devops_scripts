# DevOps Automation Script
This repository contains a script that create containers for Postgres, SonarQube, Jenkins and Nexus with persistent Data in Docker
## How to run the script
### Requirements
- Have Docker CLI already installed on a Linux environment
### Execution
1. Open terminal and clone this repository
2. Navigate to the main folder
3. Execute ```./docker_commands.sh ```
## Notes
- In case of getting error "Max virtual memory areas vm.max_map_count 65530 is too low" on Sonarqube, execute this commands:
```
sudo sysctl -w vm.max_map_count=262144
```
```
sudo systemctl restart docker
```
Now try to start up Sonarqube container again.