def COLOR_MAP = [
    'SUCCESS': 'good',
    'FAILURE': 'danger',
]

pipeline {
    agent any

    stages {
        stage('git checkout') {
            steps {
                echo 'cloning project code base...'
                git branch: 'main', url: 'https://github.com/ndengueche/airbnb-infra.git'
                sh 'ls'
            }
        }
        stage('verify terraform version') {
            steps {
                echo 'verifyin the tera version...'
                sh 'terraform --version'
            }
        }

        stage('terraform init') {
            steps {
                echo 'initialising terraform...'
                sh 'terraform init'
            }
        }

        stage('terraform validate') {
            steps {
                echo 'code syntax checkings...'
                sh 'terraform validate'
            }
        }
        stage('terraform plan') {
            steps {
                echo 'terraform plan for dry run...'
                sh 'terraform plan'
            }
        }

        stage('checkov scan') {
            steps {
                sh """
                sudo pip3 install checkov

                checkov -d . --skip-check CKV_AWS_79
                """
            }
        }

        stage('manual approval') {
            steps {
                input 'Approval required for deployment'
            }
        }

        stage('terraform apply') {
            steps {
                echo 'terraform apply...'
                sh 'sudo terraform apply --auto-approve'
            }
        }
    }

    post {
        always {
            echo 'i will always say hello again'
            slackSend channel: '#better-work', color: COLOR_MAP[currentBuild.currentResult], message: "*${currentBuild.curentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
        }
    }
}
