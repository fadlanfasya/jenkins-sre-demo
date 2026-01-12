pipeline {
    agent any

    stages {
        stage('Preparation') {
            steps {
                sh 'chmod +x deploy.sh'
            }
        }
        
        stage('Deploy New Version') {
            steps {
                // Kita kirim nomor build Jenkins sebagai penanda versi
                sh "./deploy.sh --deploy ${env.BUILD_NUMBER}"
            }
        }

        stage('Health Check') {
            steps {
                script {
                    echo "SRE: Memeriksa kesehatan aplikasi..."
                    // SIMULASI ERROR: Kita sengaja buat perintah yang salah
                    // agar Jenkins masuk ke blok failure
                    sh "ls folder_yang_tidak_ada_biar_error" 
                }
            }
        }
    }

    post {
        failure {
            echo "--- PIPELINE GAGAL ---"
            sh "./deploy.sh --rollback"
        }
        success {
            echo "--- PIPELINE BERHASIL ---"
        }
    }
}