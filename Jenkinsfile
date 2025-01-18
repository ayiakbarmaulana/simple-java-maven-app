node {
  checkout scm

  docker.image('maven:3.9.2').inside('-v /home/icama/.m2:/root/.m2 -u root') {
    stage('Build') {
      sh 'mvn -B -DskipTests clean package'
    }

    stage('Test') {
      sh 'mvn test'

      junit 'target/surefire-reports/*.xml'
  }

    stage("Manual Approval") {
      input message: 'Lanjutkan ke tahap Deploy?'
    }

    stage('Deploy') {
      sh './jenkins/scripts/deliver.sh'
      sleep(time: 60, unit: 'SECONDS')

      sh 'chmod +x ./jenkins/scripts/kill.sh'
      sh ('./jenkins/scripts/kill.sh')
    }
  }
}