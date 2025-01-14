node {
  checkout scm

  docker.image('maven:3.9.2').inside('-v /home/icama/.m2:/root/.m2 -u root') {
    stage('Build') {
      sh 'mvn -B -DskipTests clean package'
    }
  }

  stage('Test') {
    sh 'mvn test'

    junit 'target/surefire-reports/*.xml'
  }

  stage('Deliver') {
    sh './jenkins/scripts/deliver.sh'
  }
}