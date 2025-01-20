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
      sshagent(credentials: ['a54789ce-6d79-4114-a78c-1dff917fec83']) {
      sh '''
        # Ensure the .ssh directory exists
        mkdir -p ~/.ssh

        # Add the EC2 instance to known_hosts
        echo "Adding EC2 instance to known_hosts"
        ssh-keyscan -H ec2-13-215-173-108.ap-southeast-1.compute.amazonaws.com >> ~/.ssh/known_hosts
      '''
      sh 'ssh ubuntu@ec2-13-215-173-108.ap-southeast-1.compute.amazonaws.com "cd ~/simple-java-maven-app && git pull && whoami && ls -lah && ./simple-java-maven-app/jenkins/scripts/deliver.sh && sleep(time: 60, unit: 'SECONDS') && chmod +x ./jenkins/scripts/kill.sh && ./jenkins/scripts/kill.sh"'
      }
    }
  }
}
