pipeline{
    agent any;
    stages{
        stage("Code clone"){
            steps{
                git url:"https://github.com/Sourabh9125/two-tier-flask-app.git", branch:"main"
            }
        }
        stage("docker build"){
            steps{
                sh "docker build -t flask-app ." 
            }
        }
        stage("testing"){
            steps{
                echo "testing flask app "
            }
        }
        stage("Push to dockerHub"){
            steps{
                withCredentials([usernamePassword(
                    credentialsId:"dockerHubCreds",
                    passwordVariable:"dockerHubPass",
                    usernameVariable:"dockerHubUser"
                    )]){
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                    sh "docker image tag flask-app ${env.dockerHubUser}/python-flask-app"
                    sh "docker push ${env.dockerHubUser}/python-flask-app"
                }
            }
        }
        stage("deploy"){
            steps{
                sh "docker compose up -d --build flaskapp"
            }
        }
    }
    post {
        success{
            script{
                emailext from: 'lodhisaurabh9125@gmail.com',
                to: 'lodhisaurabh9125@gmail.com',
                body: 'Build success for Demo CICD App',
                subject: 'Build success for Demo CICD App'
            }
        }
        failure{
            script{
                emailext from: 'lodhisaurabh9125@gmail.com',
                to: 'lodhisaurabh9125@gmail.com',
                body: 'Build failed! for Demo CICD App',
                subject: 'Build Failure for Demo CICD App'
            }
        }
    }
    
}
