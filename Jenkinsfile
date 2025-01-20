node {
  checkout scm
 

  docker.image('maven:3.9.2').inside('-v /home/icama/.m2:/root/.m2 -u root') {

    stage('ssh') {
      sshagent(credentials: ['2bb2c58d-0711-40dc-bed5-aed5e6f6c187']) {
        echo "masuk ke dalam ec2 aws"
        sh 'ls -lah'
      }
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

// node {
//     // Konfigurasi server remote
//     def remote = [:]
//     remote.name = 'ubuntu'
//     remote.host = '13.215.173.108'
//     remote.user = 'root'
//     remote.password = 'Desember2612!'
//     remote.allowAnyHosts = true

//     // Gunakan Docker sebagai agen build
//     docker.image('maven:3.9.2').inside('-v /home/icama/.m2:/root/.m2 -u root') {
//         try {
//             stage('Checkout') {
//                 checkout scm
//             }

//             stage('Remote SSH Test') {
//                 echo 'Menguji koneksi SSH ke remote server...'
//                 sshCommand remote: remote, command: '''
//                     echo "Listing files on remote server:"
//                     ls -lrt
//                     echo "Simulating a 5-loop operation on remote server:"
//                     for i in {1..5}; do echo -n "Loop $i "; date; sleep 1; done
//                 '''
//             }

//             stage('Build') {
//                 echo 'Melakukan build aplikasi menggunakan Maven...'
//                 sh 'mvn -B -DskipTests clean package'
//             }

//             stage('Test') {
//                 echo 'Menjalankan pengujian...'
//                 sh 'mvn test'
//                 junit 'target/surefire-reports/*.xml'
//             }

//             stage('Manual Approval') {
//                 echo 'Menunggu persetujuan manual untuk melanjutkan ke tahap deploy...'
//                 input message: 'Lanjutkan ke tahap Deploy?'
//             }

//             stage('Install SSH Tools & SetUp SSH') {
//                 echo 'Menyiapkan alat SSH dan menambahkan host ke known_hosts...'
//                 sh '''
//                     apt-get update && apt-get install -y openssh-client
//                     ssh-keyscan -H ec2-13-215-173-108.ap-southeast-1.compute.amazonaws.com >> ~/.ssh/known_hosts
//                 '''
//             }

//             stage('Deploy') {
//                 echo 'Melakukan proses deployment ke remote server...'

//                 // Pastikan file PEM memiliki izin akses yang benar
//                 sh 'chmod 400 ./riasec_app.pem'

//                 sshCommand remote: [
//                     name: 'deploy-server',
//                     host: 'ec2-13-215-173-108.ap-southeast-1.compute.amazonaws.com',
//                     user: 'ubuntu',
//                     identityFile: './riasec_app.pem',
//                     allowAnyHosts: true
//                 ], command: '''
//                     cd ~/simple-java-maven-app
//                     echo "Pulling the latest code from Git..."
//                     git pull
//                     echo "Executing deployment script..."
//                     ./simple-java-maven-app/jenkins/scripts/deliver.sh
//                     echo "Waiting for services to start..."
//                     sleep 60
//                     echo "Stopping services if necessary..."
//                     chmod +x ./jenkins/scripts/kill.sh
//                     ./jenkins/scripts/kill.sh
//                 '''
//             }
//         } catch (e) {
//             // Tangani kesalahan jika ada
//             echo "Pipeline gagal dengan error: ${e.message}"
//             currentBuild.result = 'FAILURE'
//             throw e
//         }
//     }
// }
