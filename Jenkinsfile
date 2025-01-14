pipeline {
    agent {
        docker {
            image 'maven:3.9.2'
            args '-v /home/.m2:/home/.m2'
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
