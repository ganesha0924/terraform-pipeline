pipeline {
    agent any

    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'staging', 'prod'], description: 'Target environment')
    }

    
    options {
        ansiColor('xterm')
    }

    
    environment {
        TF_DIR = "environments/${params.ENVIRONMENT}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform plan -out=tfplan -input=false'
                }
            }
        }

        stage('Approval') {
            steps {
                input message: "Apply to ${params.ENVIRONMENT}? Review the plan output above."
            }
        }

        stage('Terraform Apply') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform apply -input=false tfplan'
                }
            }
        }
    }

    post {
        success {
            echo "✅ ${params.ENVIRONMENT} deploy succeeded"
        }
        failure {
            echo "❌ ${params.ENVIRONMENT} deploy failed — check logs above"
        }
    }
}
