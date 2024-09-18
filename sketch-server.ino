#include <WiFi.h>
#include <HTTPClient.h>
#include <DHT.h> 
#include <ArduinoJson.h>

#define MAX_DHT_DEVICES 10
#define DHTTYPE DHT11
DHT* dhtSensors[MAX_DHT_DEVICES];
int dhtPins[MAX_DHT_DEVICES];    
int dhtCount = 0;  

// URL dan kredensial WiFi
String URL = "http://localhost:5000/config/db.php"; 
const char* ssid = "zeru"; 
const char* password = "zeruIOT09"; 

int temperature[MAX_DHT_DEVICES] = {0};
int humidity[MAX_DHT_DEVICES] = {0};
int moisture = 0;

HTTPClient http;

void getDevice() {
    http.begin(URL);
    http.addHeader("Content-Type", "application/json");
    int httpCodeGD = http.GET();
    if (httpCodeGD > 0) {
        String payload = http.getString(); 
        // Buat buffer untuk mem-parsing JSON
        const size_t capacity = JSON_ARRAY_SIZE(10) + 10*JSON_OBJECT_SIZE(3) + 200;
        DynamicJsonDocument doc(capacity);
    
        // Parse JSON dari respon HTTP
        DeserializationError error = deserializeJson(doc, payload);

        if (error) {
            Serial.print("Gagal parsing JSON: ");
            Serial.println(error.c_str());
            return;
        }

        // Jika JSON adalah array, lakukan perulangan
        JsonArray dataArray = doc.as<JsonArray>();
        for (JsonObject data : dataArray) {
            const char* deviceName = data["device_name"]; // Ambil nilai device_name

            // Cek apakah deviceName mengandung substring "dht"
            if (String(deviceName).indexOf("dht") != -1) {
                if (dhtCount < MAX_DHT_DEVICES) {  // Pastikan tidak melebihi batas
                    dhtPins[dhtCount] = data["pin"].as<int>(); // Simpan pin di array

                    // Inisialisasi sensor DHT dengan pin yang didapat
                    dhtSensors[dhtCount] = new DHT(dhtPins[dhtCount], DHTTYPE); 
                    dhtSensors[dhtCount]->begin();  // Inisialisasi sensor DHT

                    dhtCount++;  // Tambah jumlah DHT yang ditemukan
                }
            }
        }

        // Cetak data pin DHT yang ditemukan
        for (int i = 0; i < dhtCount; i++) {
            Serial.print("DHT ");
            Serial.print(i + 1);
            Serial.print(" Pin: ");
            Serial.println(dhtPins[i]);
        }
    } else {
        Serial.print("Error code: ");
        Serial.println(httpCodeGD);
    }
    http.end();
}

void setup() {
    Serial.begin(115200);
    
    // Koneksi WiFi
    connectWiFi();
    
    // Mendapatkan dan inisialisasi sensor DHT dari API
    getDevice();
}

void loop() {
    if (WiFi.status() != WL_CONNECTED) {
        connectWiFi();
    }

    // Membaca data dari semua sensor DHT
    Load_DHT11_Data();

    String postData = "";
    for (int i = 0; i < dhtCount; i++) {
        postData += "temperature" + String(i + 1) + "=" + String(temperature[i], 2);
        postData += "&humidity" + String(i + 1) + "=" + String(humidity[i], 2);
        if (i < dhtCount - 1) {
            postData += "&";  // Tambahkan '&' jika masih ada data lain
        }
    }
    postData += "&moisture=" + String(moisture);

    http.begin(URL);
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");

    int httpCode = http.POST(postData);
    String payload = http.getString();

    Serial.print("URL : "); Serial.println(URL); 
    Serial.print("Data: "); Serial.println(postData);
    Serial.print("httpCode: "); Serial.println(httpCode);
    Serial.print("payload : "); Serial.println(payload);
    Serial.println("--------------------------------------------------");
    delay(5000);
}

// Fungsi untuk membaca data dari sensor DHT
void Load_DHT11_Data() {
    for (int i = 0; i < dhtCount; i++) {
        // Membaca suhu dan kelembapan dari setiap sensor DHT
        temperature[i] = dhtSensors[i]->readTemperature(); // Celsius
        humidity[i] = dhtSensors[i]->readHumidity();

        // Cek jika pembacaan valid
        if (isnan(temperature[i]) || isnan(humidity[i])) {
            Serial.printf("Failed to read from DHT %d sensor!\n", i + 1);
            temperature[i] = 0;
            humidity[i] = 0;
        } else {
            Serial.printf("DHT %d - Temperature: %d °C\n", i + 1, temperature[i]);
            Serial.printf("DHT %d - Humidity: %d %%\n", i + 1, humidity[i]);
        }
    }
}

// Fungsi untuk menghubungkan ke WiFi
void connectWiFi() {
    WiFi.mode(WIFI_OFF);
    delay(1000);
    WiFi.mode(WIFI_STA);
    
    WiFi.begin(ssid, password);
    Serial.println("Connecting to WiFi");
    
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }
    
    Serial.print("connected to : "); Serial.println(ssid);
    Serial.print("IP address: "); Serial.println(WiFi.localIP());
}
