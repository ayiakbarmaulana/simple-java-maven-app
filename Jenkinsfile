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

    // stage('Deliver') {
    //     withCredentials([string(credentialsId: 'a54789ce-6d79-4114-a78c-1dff917fec83')]) {
    //         sh './jenkins/scripts/deliver.sh'
    //     }
    //     sleep time: 1, unit: 'MINUTES'
    // }
  }

  //  stage('Deploy') {
  //     // Ensure the ssh-agent is initialized and running
  //     sshagent(credentials: ['a54789ce-6d79-4114-a78c-1dff917fec83']) {
  //       sh '''
  //         # Ensure the .ssh directory exists
  //         mkdir -p ~/.ssh

  //         # Add the EC2 instance to known_hosts
  //         echo "Adding EC2 instance to known_hosts"
  //         ssh-keyscan -H ec2-13-215-173-108.ap-southeast-1.compute.amazonaws.com >> ~/.ssh/known_hosts
  //       '''
  //       sh '''
  //         echo "Deploying to EC2 instance"
  //         ssh ubuntu@ec2-13-215-173-108.ap-southeast-1.compute.amazonaws.com "cd ~/simple-java-maven-app && git pull && whoami && ls -lah && ./jenkins/scripts/deliver.sh"
  //       '''
  //       sleep(time: 60, unit: 'SECONDS')

  //       sh 'chmod +x ./jenkins/scripts/kill.sh'
  //       sh './jenkins/scripts/kill.sh'
  //     }
  //   }

}
