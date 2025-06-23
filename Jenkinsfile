pipeline{
    agent any;
    stages{
        stage("code clone"){
            steps{
            git url: "https://github.com/Sourabh9125/two-tier-flask-app.git", branch: "main"
        }
    }
    stage("docker build"){
        steps{
            sh "docker build -t flask-app ."
        }
    }
    stage("testing"){
        steps{
            echo "testing the code"
        }
    }
    stage("push to dockerHub"){
        steps{
            withCredentials([usernamePassword(
                credentialsId:"dockerHubCreds",
                usernameVariable: "dockerHubUser",
                passwordVariable: "dockerHubPass")]){
            sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
            sh "docker image tag flask-app ${env.dockerHubUser}/flask-app"
            sh "docker push ${env.dockerHubUser}/flask-app"
        }
        }
    }
    stage("deploying "){
        steps{
            sh "docker compose up -d --build"
        }
    }
 }
    
}
