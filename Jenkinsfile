node {

  def remote = [:]
  remote.name = 'ubuntu'
  remote.host = '13.215.173.108'
  remote.user = 'root'
  remote.password = 'Desember2612!'
  remote.allowAnyHosts = true

  checkout scm
 

  docker.image('maven:3.9.2').inside('-v /home/icama/.m2:/root/.m2 -u root') {

    stage('Remote SSH') {
      sshCommand remote: remote, command: "ls -lrt"
      sshCommand remote: remote, command: "for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done"
    }
    
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

    stage('Install SSH Tools & SetUp SSH') {
      sh '''
        apt-get update && apt-get install -y openssh-client
        ssh-keyscan -H ec2-13-215-173-108.ap-southeast-1.compute.amazonaws.com >> ~/.ssh/known_hosts
      '''
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