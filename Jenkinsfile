pipeline {
    agent {
        docker {
            image 'maven:3.9.2'
            args '-v /home/icama/.m2:/root/.m2 -u root'
        }
    }
    stages {
        stage('Build') { 
            steps {
                sh 'mvn -B -DskipTests clean package' 
            }
        }
    }
}
