pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                echo 'Mengambil kode dari Git...'
            }
        }
        stage('Lint & Test') {
            steps {
                echo 'Menjalankan pengecekan kode (Linting)...'
                sh 'chmod +x app.sh'
            }
        }
        stage('Simulasi Deploy') {
            steps {
                echo 'Deploying ke lingkungan Staging...'
                sh './app.sh'
            }
        }
    }
    post {
        success {
            echo 'Pipeline Berhasil! Sistem Sehat.'
        }
        failure {
            echo 'Pipeline Gagal! Segera cek log.'
        }
    }
}