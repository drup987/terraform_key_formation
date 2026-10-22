pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION    = 'us-east-1'
        AWS_CREDS             = credentials('aws-credentials')
        AWS_ACCESS_KEY_ID     = "${AWS_CREDS_USR}"
        AWS_SECRET_ACCESS_KEY = "${AWS_CREDS_PSW}"
        PATH                  = "${env.WORKSPACE}/bin:${env.PATH}"
    }

    stages {
        stage('Terraform') {
            steps {
                sh '''
                    if ! command -v terraform >/dev/null; then
                        mkdir -p bin
                        curl -sSLo tf.zip https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_amd64.zip
                        unzip -o -q tf.zip -d bin && rm tf.zip
                    fi
                    terraform init
                    terraform validate
                    terraform apply -auto-approve
                '''
                script {
                    env.EC2_IP = sh(script: 'terraform output -raw public_ip', returnStdout: true).trim()
                }
                echo "Server IP: ${env.EC2_IP}"
            }
        }

        stage('Generate SSH Key') {
            steps {
                sshagent(['drup-vergina']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=accept-new ec2-user@$EC2_IP '
                            [ -f ~/.ssh/id_ed25519 ] || ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519
                            cat ~/.ssh/id_ed25519.pub
                        '
                    '''
                }
            }
        }
    }
}