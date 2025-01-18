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

    stage('Deploy') {
      sh './jenkins/scripts/deliver.sh'
      sleep(time: 30, unit: 'SECONDS')
      input message: 'Aplikasi telah berjalan selama 30 detik. Apakah Anda ingin melanjutkan? (Click "Proceed" to continue)'

      sh 'chmod +x ./jenkins/scripts/kill.sh'
      sh ('./jenkins/scripts/kill.sh')
    }
  }
}