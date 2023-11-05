pipeline {
    agent any
          
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code...'
                checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                echo 'Initializing Terraform...'
                script {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                echo 'Running Terraform plan...'
                script {
                    sh 'terraform plan -input=false -out=tfplan'
                }
            }
        }
        stage('Terraform Destroy') {
            steps {
                echo 'Destroying Terraform resources...'
                script {
                    sh 'terraform destroy -input=false -auto-approve'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                echo 'Applying Terraform changes...'
                script {
                    sh 'terraform apply -input=false tfplan'
                }
            }
        }
        
    }

    post {
        success {
            echo 'Jenkins Pipeline executed successfully!'
        }
        failure {
            echo 'Jenkins Pipeline failed!'
        }
    }
}
