node {
  try {

    checkout scm

    docker.image('maven:3.9.0').inside('-v /root/.m2:/root/.m2') {
      stage('Build') {
        sh 'docker ps'
        sh 'mvn -B -D skipTests clean package'
      }
    }

    stage('Test') {
      sh 'mvn test'
      junit 'target/surefire-reports/*.xml'
    }

    stage('Deliver') {
      sh './jenkins/scripts/deliver.sh'
    }
  } catch (err) {
    currentBuild.result = 'FAILURE'
    throw err
  }
}