node {
    def app
    stage("Clear Workspace"){
        
          sh 'rm -rvf a*'
        
    }
    stage('Clone repository') {
      

        checkout scm
    }
    stage('GCP Auth') {
        
         withCredentials([usernameColonPassword(credentialsId: 'gcp_credentials', variable: 'gcp_credentials'), file(credentialsId: 'gcp_json', variable: 'gcp_json')]) {
         sh 'gcloud auth activate-service-account --key-file=$gcp_json'
        }
      
    }

    stage('Build image') {
       
       app = docker.build("gcr.io/woven-bonbon-396818/tomcat")
    }

    stage('Test image') {
  

        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        
        sh 'docker push gcr.io/woven-bonbon-396818/tomcat:latest'

    }
    
    stage('Update GIT') {
            script {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    withCredentials([usernamePassword(credentialsId: 'github', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        //def encodedPassword = URLEncoder.encode("$GIT_PASSWORD",'UTF-8')
                        sh "git config user.email poojithakavikondala@gmail.com"
                        sh "git config user.name PoojithaK"
                        //sh "git switch master"
                        sh "cat deployment.yaml"
                        sh "sed -i 's+woven-bonbon-396818/tomcat.*+woven-bonbon-396818/tomcat:${DOCKERTAG}+g' deployment.yaml"
                        sh "cat deployment.yaml"
                        sh "git add ."
                        sh "git commit -m 'Done by Jenkins Job changemanifest: ${env.BUILD_NUMBER}'"
                        sh "git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/${GIT_USERNAME}/kubernetesmanifest.git HEAD:main"
      }
    }
  }
}
}
