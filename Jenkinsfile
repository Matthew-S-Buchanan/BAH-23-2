pipeline {
    agent any
    stages {
        stage("Clean Up"){
            steps {
                deleteDir()
            }
        }    
        stage("Pull HTML from Github Repo") {
            steps {
                sh "git clone https://github.com/Matthew-S-Buchanan/BAH-23-2.git"
            }
        }
        stage("Push file to web instance") {
            steps {
                sh "scp -r -v -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/Jenkins-Key.pem /var/lib/jenkins/workspace/capstone/web*/* ubuntu@3.95.155.82:/var/www/html"
            }
        }
    }
}
