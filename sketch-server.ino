#include <DHT.h>
#include <WiFiManager.h>
#include <Firebase.h>

#define DHTPIN 19
#define DHTTYPE DHT11 
#define MAX_SOIL_SENSORS 11  // Jumlah maksimum sensor tanah (10 sensor tanah + 1 DHT)

// Inisialisasi Firebase dengan URL database
Firebase fb("https://controler-smart-farm-default-rtdb.firebaseio.com/");

int DHTPIN_NEW = 0;  // Pin baru untuk sensor DHT dari Firebase
int soilPins[MAX_SOIL_SENSORS] = {0};  // Pin untuk sensor kelembaban tanah
float temperature = 0.0;  // Variabel untuk menyimpan suhu dari DHT
float humidity = 0.0;     // Variabel untuk menyimpan kelembaban dari DHT
int moisture[MAX_SOIL_SENSORS] = {0};  // Variabel untuk menyimpan kelembaban tanah

// Inisialisasi objek DHT
DHT dht11(DHTPIN, DHTTYPE);

void setup() {
  Serial.begin(115200);
  WiFiManager wifiManager;

  // Hubungkan ke WiFi menggunakan WiFiManager
  if (!wifiManager.autoConnect("smart-farm-server", "zerudev09")) {
    Serial.println("Gagal terhubung, rebooting...");
    delay(3000);
    ESP.restart();  
  }

  Serial.println("Terhubung ke WiFi");
  Serial.print("SSID: ");
  Serial.println(WiFi.SSID());
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());

  // Inisialisasi sensor DHT
  dht11.begin();
  
  // Ambil pin sensor tanah dan inisialisasi dari Firebase
  fb.setInt("config/load_soil_pins", 1);
  getSoilPins();
  fb.setInt("config/load_soil_pins", 0);
}

void loop() {
  // Membaca data dari sensor dan mengirim ke Firebase
  postData();
  
  delay(2500);  // Penundaan antar pengiriman data
}

void getSoilPins() {
  // Mengambil pin untuk DHT dari Firebase
  DHTPIN_NEW = fb.getInt("dataPins/dhts/dht1");
  Serial.print("Pin DHT berhasil diambil: ");
  Serial.println(DHTPIN_NEW);

  // Ambil pin untuk sensor tanah dari Firebase
  for (int i = 1; i < MAX_SOIL_SENSORS; i++) {
    String pinPath = "dataPins/soils/soil" + String(i);  // Membuat jalur dinamis untuk setiap sensor tanah
    int pin = fb.getInt(pinPath);  // Ambil nilai pin dari Firebase
    
    // Jika pengambilan data gagal
   
    // Set pin dan inisialisasi sebagai input
    if (pin > 0) {
      soilPins[i] = pin;  // Simpan pin yang valid
      pinMode(pin, INPUT);    // Set pin sebagai input
      Serial.print("Pin untuk sensor tanah ");
      Serial.print(i);
      Serial.print(" : ");
      Serial.println(pin);
    } else {
      Serial.print("Pin tidak valid untuk sensor tanah ");
      Serial.print(i);
      Serial.println(".");
    }
  }
}

void postData() {
  // Membaca suhu dan kelembaban dari sensor DHT11
  temperature = dht11.readTemperature();
  humidity = dht11.readHumidity();
  
  // Jika pembacaan gagal, reset nilai ke 0
  if (isnan(temperature) || isnan(humidity)) {
    Serial.println("Gagal membaca data dari sensor DHT!");
    temperature = 0.0;
    humidity = 0.0;
  } else {
    // Tampilkan data suhu dan kelembaban yang berhasil dibaca
    Serial.printf("Sensor DHT - Suhu: %.2f °C, Kelembaban: %.2f %%\n", temperature, humidity);
    
    // Kirim data suhu ke Firebase
    if (fb.setFloat("dataFarm/temperature", temperature)) {
        Serial.println("Berhasil mengirim data suhu");
    } else {
        Serial.println("Gagal mengirim data suhu");
    }
    
    // Kirim data kelembaban ke Firebase
    if (fb.setFloat("dataFarm/humidity", humidity)) {
        Serial.println("Berhasil mengirim data kelembaban");
    } else {
        Serial.println("Gagal mengirim data kelembaban");
    }
  }
  
  // Membaca dan mengirim data kelembaban tanah dari setiap sensor
  for (int i = 1; i < MAX_SOIL_SENSORS; i++) {
    if (soilPins[i] > 0) {
      int sensor_analog = analogRead(soilPins[i]);  // Baca nilai analog dari sensor tanah
      moisture[i] = 100 - ((sensor_analog / 4095.0) * 100);  // Hitung kelembaban tanah sebagai persentase
      moisture[i] = constrain(moisture[i], 0, 100);  // Batasi nilai kelembaban antara 0 hingga 100
      
      // Tampilkan data kelembaban tanah
      Serial.printf("Sensor Tanah %d - Kelembaban: %d%%\n", i + 1, moisture[i]);
      String path = "dataFarm/moisture" + String(i);  // Buat jalur Firebase untuk menyimpan data sensor

      // Kirim data kelembaban tanah ke Firebase
      if (fb.setFloat(path, moisture[i])) {
        Serial.print("Berhasil mengirim data kelembaban tanah sensor ");
        Serial.println(i);
      } else {
        Serial.print("Gagal mengirim data kelembaban tanah sensor ");
        Serial.println(i);
      }
    } 
  }
}
