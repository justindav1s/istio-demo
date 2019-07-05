#!groovy

node('nodejs') {

    stage('Checkout Source') {
      git url: "${git_url}", branch: 'master'
    }

    dir("src/${app_name}") {

      def project  = "${org}"
      def sonar_url    = "http://sonarqube.cicd.svc:9000"

      stage('npm') {
        sh 'cat src/environments/environment.ts'
        sh 'npm install'
      }


      stage('Dev : Angular build') {
        sh 'node_modules/.bin/ng build'
      }

      //Build the OpenShift Image in OpenShift and tag it.
      stage('Dev : Build and Tag OpenShift Image') {
        echo "Building OpenShift container image ${app_name}:${devTag}"
        echo "Project : ${project}"
        echo "App : ${app_name}"

        sh "oc start-build ${app_name} --follow --from-dir=dist/Angular7 -n ${project}"
        openshiftVerifyBuild apiURL: '', authToken: '', bldCfg: app_name, checkForTriggeredDeployments: 'false', namespace: project, verbose: 'false', waitTime: ''
        openshiftTag alias: 'false', apiURL: '', authToken: '', destStream: app_name, destTag: devTag, destinationAuthToken: '', destinationNamespace: project, namespace: project, srcStream: app_name, srcTag: 'latest', verbose: 'false'
      }

      // Deploy the built image to the Development Environment.
      stage('Dev :  Deploy') {
        echo "Deploying container image to Development Project"
        echo "Project : ${project}"
        echo "App : ${app_name}"
        echo "Dev Tag : ${devTag}"

        sh "oc set image dc/${app_name} ${app_name}=docker-registry.default.svc:5000/${project}/${app_name}:${devTag} -n ${project}"

        openshiftDeploy apiURL: '', authToken: '', depCfg: app_name, namespace: project, verbose: 'false', waitTime: '180', waitUnit: 'sec'
        openshiftVerifyDeployment apiURL: '', authToken: '', depCfg: app_name, namespace: project, replicaCount: '1', verbose: 'false', verifyReplicaCount: 'true', waitTime: '180', waitUnit: 'sec'
      }
    }
}
