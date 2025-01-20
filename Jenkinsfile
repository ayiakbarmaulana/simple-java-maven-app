node {
  checkout scm
 
  stage('ssh') {
    sshagent(['a54789ce-6d79-4114-a78c-1dff917fec83']) {
      echo "masuk ke dalam ec2 aws"
      sh 'whoami'
      sh 'ls -lah'
    }
  }

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
      sh 'chmod 400 ./riasec_app.pem'
      sh 'ssh -i "riasec_app.pem" ubuntu@ec2-13-215-173-108.ap-southeast-1.compute.amazonaws.com'

      sh '''
        cd ~/simple-java-maven-app
        git pull
      '''
      sh './simple-java-maven-app/jenkins/scripts/deliver.sh'
      sleep(time: 60, unit: 'SECONDS')

      sh 'chmod +x ./jenkins/scripts/kill.sh'
      sh ('./jenkins/scripts/kill.sh')
    }
  }
}
