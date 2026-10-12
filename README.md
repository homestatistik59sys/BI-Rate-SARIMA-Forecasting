# Univariate Time Series Forecasting on Bank Indonesia Interest Rate (BI Rate) Using Optimal SARIMA Model

Proyek portofolio ini menyajikan analisis deret waktu tunggal (univariate time series analysis) untuk memodelkan fluktuasi historis dan memproyeksikan arah pergerakan Suku Bunga Acuan Bank Indonesia (BI Rate) periode 2010-2025 dengan menggunakan R Studio.

## Ringkasan Eksekutif (Executive Summary)

Penelitian ini menerapkan metodologi Box-Jenkins secara komprehensif melalui enam tahapan terukur: Identifikasi Data, Uji Stasioneritas, Identifikasi Ordo Korelogram, Estimasi & Seleksi Model, Uji Diagnostik Asumsi, serta Proyeksi Interaktif (Forecasting).

Dari hasil analisis eksplorasi awal pada data level periode 2010-2025, secara visual terdeteksi fluktuasi jangka panjang yang sangat dinamis (non-mean reverting). Pembuktian matematis menggunakan Augmented Dickey-Fuller (ADF) Test pada tingkat level menghasilkan nilai p-value sebesar 0.2171 (> 0.05), yang mengonfirmasi bahwa data awal tidak stasioner dan mengandung unit root. Stasioneritas mutlak berhasil dicapai setelah dilakukan transformasi pembedaan pertama (Differencing 1x, d = 1) yang ditunjukkan oleh penurunan dramatis p-value ADF menjadi 0.01 (< 0.05).

Melalui seleksi model otomatis berbasis kriteria minimisasi kriteria informasi, ditetapkan model SARIMA(0,1,0)(0,0,2) sebagai model terbaik dan paling efisien (parsimonious model). Model ini menghasilkan nilai Akaike Information Criterion (AIC) terkecil sebesar 263.15, jauh lebih unggul dibandingkan model alternatif ARIMA klasik (0,1,1) tanpa seasonal yang menghasilkan AIC sebesar 288.11. Model SARIMA terpilih ini telah lolos uji kelayakan eror secara ketat melalui Ljung-Box Test formal dengan menghasilkan p-value sebesar 0.7329 (> 0.05), membuktikan bahwa komponen sisaan (residual) model telah bersih dari autokorelasi dan bersifat acak sempurna (White Noise).

## Proyeksi BI Rate & Evaluasi Risiko (Tahun 2026)

Hasil peramalan menunjukkan fase stabilisasi awal di level 4.75%, diikuti penyesuaian minor ke level 4.67% pada pertengahan tahun, dan ditutup oleh fluktuasi musiman akhir tahun di kisaran 4.92% hingga 5.04%. 

| Periode (2026) | Prediksi Nilai Tengah Model | Aktual BI-Rate Riil | Status Evaluasi Risiko |
| :--- | :---: | :---: | :--- |
| **Agustus** | 4,67% | 5,75% | Di dalam Batas Interval 95% |
| **September** | 5,04% | 5,75% | Di dalam Batas Interval 95% |
| **Oktober** | 5,04% | 5,75% | Di dalam Batas Interval 95% |

Meskipun terdapat deviasi minor terhadap nilai tengah proyeksi akibat kebijakan intervensi mendadak Bank Indonesia yang menahan suku bunga di level 5.75% guna menjaga stabilitas nilai tukar Rupiah dari guncangan geopolitik global, angka riil 5.75% tersebut terbukti tetap berada di dalam koridor rentang batas atas selang kepercayaan 95% (Confidence Interval) model yang mencapai 7.49%. Secara kaidah manajemen risiko, model SARIMA yang dibangun terbukti memiliki keandalan yang sangat tinggi dalam memetakan tren musiman serta menyediakan batasan risiko ketidakpastian makroekonomi yang akurat.

---
*Seluruh laporan komprehensif, grafik interaktif, dan visualisasi dokumentasi lengkap dalam format PDF dapat diakses melalui dokumen portofolio utama.*
