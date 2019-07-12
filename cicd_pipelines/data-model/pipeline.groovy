#!groovy

node('maven') {

    stage('Checkout Source') {
        git url: "${git_url}", branch: 'master'
    }

    dir('src/data-model') {

        def mvn          = "mvn -U -B -q -s ../settings.xml -Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true"
        def dev_project  = "${org}-dev"
        def prod_project = "${org}-prod"

        stage('Build jar') {
            echo "Building ........"
            sh "${mvn} clean package -DskipTests"
        }

        // Using Maven run the unit tests
        stage('Unit Tests') {
            echo "Running Unit Tests"
            sh "${mvn} test"
        }

        // Publish the built war file to Nexus
        stage('Publish to Nexus') {
            echo "Publish to Nexus"
            sh "${mvn} deploy -DskipTests"
        }

    }
}
