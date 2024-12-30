pipeline {
    
    agent any 
    
    stages {
        
        stage('Static Code Analysis') {
      environment {
        scannerHome = tool 'Sonar'
      }
      steps {
        script {
          withSonarQubeEnv('Sonar') {
            sh "${scannerHome}/bin/sonar-scanner \
                            -Dsonar.projectKey=TodoApp \
                            -Dsonar.projectName=TodoApp \
                            -Dsonar.projectVersion=1.0 \
                            -Dsonar.sources=."
          }
        }
      }
    }

        stage('Build Docker'){
          environment {
            DOCKER_IMAGE = "gbengard/todo-app:${BUILD_NUMBER}"        
            REGISTRY_CREDENTIALS = credentials('docker-cred')
      }
      steps {
        script {
            sh 'docker build -t ${DOCKER_IMAGE} .'
        }
      }
    }

        stage('Push Image'){
            environment {
                DOCKER_IMAGE = "gbengard/todo-app:${BUILD_NUMBER}"        
                REGISTRY_CREDENTIALS = credentials('docker-cred')
            }
           steps{
                script{
                    def dockerImage = docker.image("${DOCKER_IMAGE}")
                    docker.withRegistry('https://index.docker.io/v1/', "docker-cred") {
                        dockerImage.push()
                    }
                }
            }
        }
        
        
        
        stage('Update K8S manifest & push to Repo'){
            environment {
            GIT_REPO_NAME = "python-jenkins-sonar-argocd-k8s"
            GIT_USER_NAME = "gbengard"
        }
            steps {
                script{
                    withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]) {
                        sh '''
                        git config user.email "gbengardo@gmail.com"
                        git config user.name "gbengard"
                        BUILD_NUMBER=${BUILD_NUMBER}
                        git fetch origin main
                        git checkout main
                        sed -i "s/image:.*/image: gbengard\\/todo-app:${BUILD_NUMBER}/" deploy/deploy.yaml                    
                        cat deploy/deploy.yaml
                        git clean -fd
                        git add deploy/deploy.yaml
                        git commit -m "Update deployment image to version ${BUILD_NUMBER}"
                        git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} main
                '''
                    }
                }
            }
        }
    }
}
