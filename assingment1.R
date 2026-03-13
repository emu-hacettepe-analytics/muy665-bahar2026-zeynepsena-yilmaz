# ---------------------------------------------------------
# MÜY665 Ödev-1: Veri Analizi ve Temizleme
# ---------------------------------------------------------

# 1. ADIM: Gerekli Paketlerin Yüklenmesi ve Çağrılması
# Not: Eğer bilgisayarında yüklü değilse install.packages("dslabs") yapmalısın.
library(dslabs)
library(dplyr) # Veri manipülasyonu için kolaylık sağlar
library(tidyr) # replace_na fonksiyonu için

# 2. ADIM: Kişisel Bilgilerin Tanımlanması
my_first <- "Zeynep Sena"          # Buraya kendi adınızı yazın
my_birth_year <- 1997         # Buraya kendi doğum yılınızı yazın

# 3. ADIM: k Değerinin Hesaplanması
k <- (nchar(my_first) + my_birth_year) %% 15 + 8
print(paste("Hesaplanan k degeri:", k))

data("polls_us_election_2016")
original_data <- polls_us_election_2016

new_data <- original_data



new_data <- original_data %>%
  # Sayısal sütunlardaki NA'ları değiştir
  mutate(across(where(is.numeric), ~replace_na(.x, my_birth_year + k))) %>%
  # Metin veya Faktör sütunlardaki NA'ları değiştir (Hata vermez!)
  mutate(across(where(~is.character(.x) | is.factor(.x)), 
                ~replace_na(as.character(.x), paste0(my_first, "_", k))))

# --- KONTROL AŞAMASI ---

# Toplam NA sayısı 0 çıkmalı
print(sum(is.na(new_data)))

# Doğrulama (Sonuç FALSE çıkmalı)
print(anyNA(new_data))