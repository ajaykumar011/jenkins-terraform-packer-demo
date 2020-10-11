pipeline {
 agent any
 options {
        timeout(time: 1, unit: 'HOURS') 
        timestamps() 
        buildDiscarder(logRotator(numToKeepStr: '5'))
        //skipDefaultCheckout() //skips the default checkout.
        //checkoutToSubdirectory('subdirectory') //checkout to a subdirectory
        // preserveStashes()   Preserve stashes from completed builds, for use with stage restarting
        }

 environment {
        FULL_PATH_BRANCH = "${sh(script:'git name-rev --name-only HEAD', returnStdout: true)}"
        GIT_BRANCH = FULL_PATH_BRANCH.substring(FULL_PATH_BRANCH.lastIndexOf('/') + 1, FULL_PATH_BRANCH.length())
        }
     
  stages {
        stage('Checkout') {
            steps {
                script{
                    //git branch: 'Your Branch name', credentialsId: 'Your crendiatails', url: ' Your BitBucket Repo URL '
                    // Branch name is master in this repo
                    git branch: 'master', credentialsId: 'github-cred', url: 'https://github.com/ajaykumar011/jenkins-terraform-pipeline-test/'
                    echo 'Pulling... ' + env.GIT_BRANCH
                    sh 'printenv'
                   //sh "ls -la ${pwd()}"  
                    sh "tree ${env.WORKSPACE}"
                }
            }
        }

        stage('Packer-AMI-Builder') {
            steps {
                script {
                    // Get the Terraform tool.
                    //def tfHome = tool name: 'Terraform', type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
                    def tfHome = tool name: 'Terraform'
                    env.PATH = "${tfHome}:${env.PATH}"
                    sh 'terraform --version'
                }
             }
        }

        stage('Set Terraform path') {
            steps {
                script {
                    // Get the Terraform tool.
                    //def tfHome = tool name: 'Terraform', type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
                    def tfHome = tool name: 'Terraform'
                    env.PATH = "${tfHome}:${env.PATH}"
                    sh 'terraform --version'
                }
             }
        }
 
    stage('Provision infrastructure') {
         steps {
            //dir('dev')
            //    {
                sh 'terraform init'
                sh 'terraform plan -out=plan'
                // sh 'terraform destroy -auto-approve'
                sh 'terraform apply plan'
              //  }
            }
        }
    
        stage('Infra-Destroy') {
            input {
                message "Should we destroy the infrastructre ?"
                ok "Yes, we should."
                submitter "alice,bob"
                parameters {
                    string(name: 'PERSON', defaultValue: 'Ajay Kumar', description: 'Who should I say hello to?')
                    choice(name: 'INFRA-DEL', choices: ['Yes', 'No', 'nochange'], description: 'Pick yes to display all')
                }
             }
            steps {
                echo "Hello, ${PERSON}, nice to meet you."
                sh 'terraform destroy -auto-approve'
                }
            when { 
                environment name: 'INFRA-DEL', value: 'Yes'
            }

        }

    }
}
