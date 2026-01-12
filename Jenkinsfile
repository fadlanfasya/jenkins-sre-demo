pipeline {
    agent any

    stages {
        stage('Pre-Health Check') {
            steps {
                echo 'SRE Stage: Memeriksa kesehatan server sebelum deploy...'
                // Mengecek apakah penggunaan RAM di atas 90%
                sh '''
                    FREE_RAM=$(free | grep Mem | awk '{print $4/$2 * 100.0}')
                    echo "RAM tersedia: $FREE_RAM %"
                '''
            }
        }

        stage('Build & Test') {
            steps {
                echo 'Membangun aplikasi...'
                sh 'chmod +x app.sh'
                sh './app.sh --test'
            }
        }

        stage('Deploy with Safety Gate') {
            steps {
                echo 'Melakukan Deployment...'
                // Simulasi deploy
                sh './app.sh --deploy'
            }
        }

        stage('Post-Mortem / Validation') {
            steps {
                echo 'SRE Stage: Verifikasi sistem setelah perubahan...'
                // Cek apakah aplikasi benar-benar running
                sh 'ps aux | grep app.sh || echo "Warning: Aplikasi tidak ditemukan!"'
            }
        }
    }

    post {
        always {
            echo 'Membersihkan workspace...'
            cleanWs()
        }
        success {
            echo 'Status: BERHASIL. SLO (Service Level Objective) aman.'
        }
        failure {
            echo 'Status: GAGAL! Mengirim alert ke tim SRE...'
            // Di sini biasanya ada integrasi ke Slack atau PagerDuty
        }
    }
}