pipeline {
    agent none

    environment {
        JAVA_HOME = "/opt/java/openjdk"
        PATH = "${JAVA_HOME}/bin:${PATH}"
    }

    stages {
        stage('Compile on Slave 1') {
            agent { label 'slave1' }
            steps {
                sh 'mvn clean compile'
                stash includes: '**/target/**', name: 'compiled-code'
            }
        }

        stage('Test on Slave 2') {
            agent { label 'slave2' }
            steps {
                unstash 'compiled-code'
                sh 'mvn test'
            }
        }
    }

    post {
        always {
            junit '**/target/surefire-reports/*.xml'
        }
    }
}
