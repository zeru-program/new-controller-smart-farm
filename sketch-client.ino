#include <LiquidCrystal_I2C.h>
#include <Wire.h> 
#include <Firebase.h>
#include <WiFiManager.h>

// Maksimum jumlah relay pin yang dapat digunakan
const int MAX_RELAY_PINS = 3; 
// lampu biru esp menandakan esp client
const int espLed = 2;
// Array untuk menyimpan pin relay pompa dan kipas
int relayPumpPins[MAX_RELAY_PINS] = {0};
int relayFanPins[MAX_RELAY_PINS] = {0};

// Inisialisasi koneksi Firebase
Firebase fb("https://controler-smart-farm-default-rtdb.firebaseio.com/");

// Inisialisasi LCD dengan alamat I2C 0x27 dan ukuran 16x2
LiquidCrystal_I2C lcd(0x27,16,2);

// Fungsi untuk mengambil pin relay pompa dari Firebase
void getRelayPumpPins() {
  for (int i = 1; i < MAX_RELAY_PINS; i++) {
      String path = "dataPins/pumps/pump" + String(i);
      int pin = fb.getInt(path);

      if (pin > 0) {
        relayPumpPins[i] = pin;
        pinMode(pin, OUTPUT);
        digitalWrite(pin, HIGH);
        Serial.println("Data pump" + String(i) + " is " + String(pin));// Mengambil pin dari Firebase
      } else {
        Serial.print("Pin");
        Serial.print(i);
        Serial.print(" tidak valid : ");
        Serial.print(pin);
        Serial.println(".");
        continue;
      }
  }
}

// Fungsi untuk mengambil pin relay kipas dari Firebase
void getRelayFanPins() {
  for (int i = 1; i < MAX_RELAY_PINS; i++) {
      String path = "dataPins/fans/fan" + String(i);
      int pin = fb.getInt(path);

      if (pin > 0) {
       relayFanPins[i] = pin;
        pinMode(pin, OUTPUT);
        digitalWrite(pin, HIGH);
       Serial.println("Data fan" + String(i) + " is " + String(pin));// Mengambil pin dari Firebase
      } else {
        Serial.print("Pin fan" + String(i) + " tidak valid :  ");
        Serial.print(pin);
        Serial.println(".");
        continue;
      }
  }
}

// Fungsi untuk mendapatkan status pompa dan mengontrol relay
void getPumpStatus(int pumpNumber) {
    String path = "dataRelay/pump" + String(pumpNumber);
    
    int result = fb.getInt(path); 
    int pinsPump = relayPumpPins[pumpNumber];
    Serial.println("pump"+ String(pinsPump) + " is " + String(result));
    
      if (result == 1) {
        digitalWrite(pinsPump, LOW); // Aktifkan relay (ON)
      }
      else if (result == 0) {
        digitalWrite(pinsPump,   HIGH); // Matikan relay (OFF)
      }  else {
          Serial.println("error result pump not found");
      }
   
}

// Fungsi untuk mendapatkan status kipas dan mengontrol relay
void getFanStatus(int fanNumber) {
    String path = "dataRelay/fan" + String(fanNumber);
    
    int result = fb.getInt(path); // Mengambil status kipas dari Firebase
    int pinsFan = relayFanPins[fanNumber];
    Serial.println("fan"+ String(pinsFan) + " is " + String(result));
    

      if (result == 1) {
        digitalWrite(pinsFan, LOW); // Aktifkan relay (ON)
      } 
      // Jika status kipas tidak aktif, matikan relay
      else if (result == 0) {
        digitalWrite(pinsFan, HIGH); // Matikan relay (OFF)
      } 
      // Jika tidak ditemukan status
      else {
          Serial.println("error result fan not found");
      }
   
}

void setup() {
  Serial.begin(115200);
  
  pinMode(espLed, OUTPUT);
  
  // Inisialisasi LCD
  lcd.init();
  lcd.backlight();
  lcd.setCursor(0, 0);
  lcd.print("WiFi manager");
  lcd.setCursor(0, 1);
  lcd.print("Connection..");
  
  // Inisialisasi WiFiManager untuk menghubungkan ke WiFi
  WiFiManager wifiManager;

  // Menjalankan konfigurasi WiFi secara otomatis
  if (!wifiManager.autoConnect("smart-farm-client", "zerudev09")) {
    digitalWrite(espLed, LOW);
    Serial.println("Gagal terhubung, rebooting...");
    delay(3000);
    ESP.restart();  // Reboot jika gagal
  }

  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Connected!");
  digitalWrite(espLed, HIGH);
  Serial.println("Terhubung!");
  lcd.clear();
  
  Serial.print("lcd animation..");
  lcd.setCursor(0, 0);
  lcd.print("Loading");
  
  // Menampilkan animasi loading
  animateLoading(1);
  
  // Menampilkan teks selamat datang
  teksWelcomingLcd();
  lcd.clear();
  
  // Mengambil pin relay dari Firebase
  lcd.setCursor(0, 0);
  lcd.print("GET relay pins..");
  lcd.setCursor(0, 1);
  lcd.print("GET soil pins..");
  getRelayPumpPins();
  getRelayFanPins();
  lcd.clear();
}

void loop() {
  // Mengambil dan mengatur status relay untuk pompa dan kipas
  getPumpStatus(1);
  getFanStatus(1);
  
  // Mengambil dan menampilkan data suhu serta kelembaban tanah
  getDataTemp();
  getDataMoisture(1);
  
  delay(1);
}

// Fungsi untuk mendapatkan dan menampilkan data suhu dari Firebase
void getDataTemp() {
    int result = fb.getInt("dataFarm/temperature"); // Mengambil suhu dari Firebase
    
    lcd.setCursor(11, 0);
    lcd.print("     ");
    lcd.setCursor(0, 0);
    lcd.print("Temp     :  ");
    lcd.setCursor(11, 0);
    lcd.print(String(result) + (char)223 + "C"); // Menampilkan suhu di LCD
   
}

// Fungsi untuk mendapatkan dan menampilkan data kelembaban tanah dari Firebase
void getDataMoisture(int pin) {
   int result = fb.getInt("dataFarm/moisture" + String(pin)); // Mengambil kelembaban tanah dari Firebase
    
    lcd.setCursor(11, 1);
    lcd.print("     ");
    lcd.setCursor(0, 1);
    lcd.print("Humidity : ");
    lcd.setCursor(11, 1);
    lcd.print(String(result) + "%");
}

// Fungsi animasi loading pada LCD
void animateLoading(int repeats) {
  for (int r = 0; r < repeats; r++) {
    for (int i = 0; i < 10; i++) {
      lcd.setCursor(i, 1);
      lcd.print(".");
      delay(200); // Menampilkan titik-titik dengan jeda 200ms
    }
    lcd.setCursor(0, 1);
    lcd.print("          ");
    delay(200);
  }
  lcd.clear();
  delay(500);
}

// Fungsi untuk menampilkan teks selamat datang di LCD
void teksWelcomingLcd() {
  const char* welcomeText = "WELCOME";
  const char* smartFarmText = "TO SMART FARM";

  // Menampilkan teks "WELCOME" karakter per karakter
  lcd.setCursor(4, 0);
  for (int i = 0; welcomeText[i] != '\0'; i++) {
    lcd.print(welcomeText[i]);
    delay(100); // Jeda 100ms untuk setiap karakter
  }

  delay(1000); // Jeda 1 detik sebelum menampilkan baris berikutnya

  // Menampilkan teks "TO SMART FARM" karakter per karakter
  lcd.setCursor(1, 1);
  for (int i = 0; smartFarmText[i] != '\0'; i++) {
    lcd.print(smartFarmText[i]);
    delay(100); // Jeda 100ms untuk setiap karakter
  } 

  delay(5000);
  lcd.clear();
}
