// node {
//   try {

//     checkout scm

//     docker.image('maven:3.9.2').inside('-v /root/.m2:/root/.m2') {
//       stage('Build') {
//         sh 'mvn -B -D skipTests clean package'
//       }
//     }

//     stage('Test') {
//       sh 'mvn test'
//       junit 'target/surefire-reports/*.xml'
//     }

//     stage('Deliver') {
//       sh './jenkins/scripts/deliver.sh'
//     }
//   } catch (err) {
//     currentBuild.result = 'FAILURE'
//     throw err
//   }
// }

pipeline {
    agent {
        docker {
            image 'maven:3.9.0'
            args '-v /root/.m2:/root/.m2'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Deliver') {
            steps {
                sh './jenkins/scripts/deliver.sh'
            }
        }
    }
}
