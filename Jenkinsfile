@Library('shared') _
pipeline{
    agent {label 'dev'};
    stages{
        stage("workspace clean"){
            steps{
                script{
                  clean_ws()
                }
            }
        }
        stage("code clone"){
            steps{
                script{
            clone("https://github.com/Sourabh9125/two-tier-flask-app.git", "main")
                }
        }
    }
        
        stage("trivy scan"){
            steps{
                script{
                    trivy()
                }
            }
        }
        stage("docker build"){
        steps{
            script{
            docker_build("flask-app-two","v1.2") 
            }
        }
    }
        stage("testing"){
        steps{
            echo "testing the code"
        }
    }
        stage("push to dockerHub"){
        steps{
            script{
                docker_hub("dockerHubCreds", "flask-app","v1.2")
            }
        }
    }
        stage("deploying "){
        steps{
            script{
                docker_compose()
            }
        }
    }
 }

 post{
     failure{
         script{
             emailext from: "lodhisaurabh9125@gmail.com",
             to: "lodhisourabh4678@gmail.com",
             body: "pipeline failure check immeidatly",
             subject: "pipeline status"
         }
     }
 }   
}
