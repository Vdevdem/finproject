pipeline {
    agent any
    stages {
        stage('Setting up database'){
            steps{
            withCredentials([string(credentialsId: 'RDS_ENDPOINT', variable: 'RDS_ENDPOINT'), string(credentialsId: 'RDS_USERNAME', variable: 'RDS_USERNAME'), string(credentialsId: 'RDS_PASSWORD', variable: 'RDS_PASSWORD')]) {
                sh 'bash ./Jenkins/Scripts/Database/database.sh'
            }
        }
        }

        stage('Testing'){
            steps{
                sh 'bash ./Jenkins/Scripts/Test/test_app.sh'
            }
        }

        stage('Build images'){
            steps{
                 withCredentials([string(credentialsId: 'DOCKER_USERNAME', variable: 'DOCKER_USERNAME'), string(credentialsId: 'DOCKER_PASSWORD', variable: 'DOCKER_PASSWORD')]) {
                    sh 'bash ./Jenkins/Scripts/Docker/install-docker.sh'
                    sh 'bash ./Jenkins/Scripts/Docker/build_images.sh'
                }
            }
        }
        stage('Create Docker Container') {
            steps {
                echo 'Start creating Docker Container'
                sh 'cd spring-petclinic; ./mvnw spring-boot:build-image'
                sh 'docker tag spring-petclinic:2.7.0-SNAPSHOT docker:5000/petclinic:v$BUILD_NUMBER'
                echo 'End creating Docker Container'
            }
        }

        stage('Push Docker Container to Docker Registry') {
            steps {
               echo 'Stast push Docker Container to Docker Registry'
               sh 'docker push docker:5000/petclinic:v$BUILD_NUMBER'
               echo 'End push Docker Container to Docker Registry'
            }
        }
        stage('Deploy images'){
            steps{
                withCredentials([string(credentialsId: 'SECRET_ACCESS_KEY', variable: 'SECRET_ACCESS_KEY'), string(credentialsId: 'ACCESS_KEY_ID', variable: 'ACCESS_KEY_ID')]) {
                    sh 'bash ./Jenkins/Scripts/Kubernetes/install_dependencies.sh'
                    sh 'bash ./Jenkins/Scripts/Kubernetes/deploy_pods.sh'
                    sh 'bash ./Jenkins/Scripts/Kubernetes/reroute_dns.sh'
                }
            }
        }
        }
    }
