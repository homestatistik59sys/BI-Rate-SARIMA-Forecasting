# =========================================================================
# PROYEK PORTOFOLIO: ANALISIS TIME SERIES INTEGRATIF BI RATE (2010 - 2025)
# METODE: OPTIMAL SEASONAL ARIMA (SARIMA) DENGAN GGPLOT2 & PLOTLY INTERAKTIF
# PENYUSUN: ROFINUS RAMANG (DATA ANALYST / QUANTITATIVE RESEARCHER)
# =========================================================================

# -------------------------------------------------------------------------
# TAHAP 1: INISIALISASI DATA, PEMBERSIHAN KRONOLOGIS, & EKSPLORASI TREN
# -------------------------------------------------------------------------

# 1. SETUP LIBRARY GLOBAL
library(readxl)
library(tidyverse)
library(forecast)
library(tseries)
library(lubridate)
library(scales)
library(plotly)

# 2. SET WORKING DIRECTORY & IMPORT DATA MENTAH
setwd("C:/Users/CPUQ/Downloads")
data_mentah <- read_excel("BI RATE FORCATING.xlsx")

# 3. ADVANCED DATA CLEANING (SINKRONISASI KRONOLOGIS & FORMAT NUMERIK)
data_bersih <- data_mentah %>%
  rename(
    No = 1,
    Bulan_Tahun_Teks = 2,
    BI_Rate_Mentah = 3
  ) %>%
  mutate(
    BI_Rate_Mentah = as.character(BI_Rate_Mentah),
    BI_Rate_Clean = gsub("%", "", BI_Rate_Mentah),
    BI_Rate_Clean = gsub(",", ".", BI_Rate_Clean),
    BI_Rate_Clean = as.numeric(gsub("[[:space:]]", "", BI_Rate_Clean))
  ) %>%
  mutate(
    Tanggal_Resmi = parse_date_time(Bulan_Tahun_Teks, orders = c("my", "dmy", "B Y", "b y")),
    Bulan_Flat = floor_date(Tanggal_Resmi, "month")
  ) %>%
  filter(!is.na(Bulan_Flat), !is.na(BI_Rate_Clean)) %>%
  arrange(Bulan_Flat) %>%
  group_by(Bulan_Flat) %>%
  summarise(Rate_Final = last(BI_Rate_Clean)) %>%
  ungroup() %>%
  complete(Bulan_Flat = seq.Date(min(Bulan_Flat), max(Bulan_Flat), by="month")) %>%
  fill(Rate_Final, .direction = "down")

# Transformasi data bersih ke objek Time Series resmi R
bi_ts %
mutate(
  Jenis = "Data Historis (Aktual)",
  Lower95 = NA,
  Upper95 = NA,
  Rate_Final = round(Rate_Final, 2)
)

df_forecast_final <- data.frame(
  Bulan_Flat = forecast_dates,
  Rate_Final = round(as.numeric(ramalan_masa_depan$mean), 2),
  Lower95 = round(as.numeric(ramalan_masa_depan$lower[,2]), 2),
  Upper95 = round(as.numeric(ramalan_masa_depan$upper[,2]), 2),
  Jenis = "Proyeksi Ramalan (Forecast)"
)

# 3. MEMBUAT LAYER GGPLOT DASAR ANTI-BIAS VISUAL
p_portfolio <- ggplot() +
  # LAYER A: Bayangan Ketidakpastian 95% (HANYA Area Forecast)
  geom_ribbon(data = df_forecast_final, 
              aes(x = Bulan_Flat, ymin = Lower95, ymax = Upper95, group = 1,
                  text = paste0("<b>Batas Batas Toleransi Risiko</b><br>",
                                "Periode: ", format(Bulan_Flat, "%B %Y"), "<br>",
                                "Batas Bawah 95%: ", Lower95, "%<br>",
                                "Batas Atas 95%: ", Upper95, "%")), 
              fill = "#003366", alpha = 0.15) +
  # LAYER B: Garis Fluktuatif Historis Aktual (Deep Navy Blue)
  geom_line(data = df_historis_final, 
            