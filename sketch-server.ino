#include <WiFi.h>
#include <HTTPClient.h>
#include <DHT.h>
#include <WiFiManager.h>
#include <Firebase.h>

#define DHTPIN 19
#define DHTTYPE DHT11 
#define MAX_SOIL_SENSORS 3 // Maksimum 10 soil sensors
// Firebase config details

// URL hosting file
// String URL = "http://192.168.109.60/smart-farm/config/"; 
Firebase fb("https://controler-smart-farm-default-rtdb.firebaseio.com/");
String URL = "";

// WiFi credentials
const char* ssid = "zeru"; 
const char* password = "zeruIOT09"; 

int soilPins[MAX_SOIL_SENSORS] = {0}; // Array untuk pin soil sensor
float temperature = 0.0; 
float humidity = 0.0;
int moisture[MAX_SOIL_SENSORS] = {0};

// DHT object untuk satu sensor
DHT dht11(DHTPIN, DHTTYPE);

// Fungsi untuk mendapatkan pin soil sensor dari server
void getSoilPins() {
  // HTTPClient http;
  // for (int i = 1; i <= MAX_SOIL_SENSORS; i++) {
  //   String url = URL + "getDevice.php?soil=" + i;
  //   http.begin(url);
  //   int httpCode = http.GET();
  //   if (httpCode > 0) {
  //     String payload = http.getString();
  //     Serial.print("Payload for soil "); Serial.print(i); Serial.print(": "); Serial.println(payload);

  //   //  int pin = payload.toInt(); // Konversi payload ke integer
  //     // int pin = fb.getInt("data/-O6CRRduZZleytOeBYMw/soilPin1");
  //     // if (pin > 0) {
  //     //   soilPins[i - 1] = pin; // Simpan nilai pin
  //     //   pinMode(pin, INPUT); // Set pin sebagai input
  //     // } else {
  //     //   Serial.print("Invalid pin for soil sensor "); Serial.print(i); Serial.println(".");
  //     // }
  //   } else {
  //     Serial.print("Error code: ");
  //     Serial.println(httpCode);
  //   }
  //   http.end();
  // }
   for (int i = 1; i <= MAX_SOIL_SENSORS; i++) {
    // Membentuk jalur dinamis untuk mengambil data dari Firebase
    String pinPath = "data/-O6CRRduZZleytOeBYMw/soilPin" + String(i);
    
    // Mengambil nilai pin dari Firebase
    int pin = fb.getInt(pinPath);
    
    if (pin > 0) {
      soilPins[i - 1] = pin; // Simpan nilai pin
      pinMode(pin, INPUT);    // Set pin sebagai input
      Serial.print("Pin untuk sensor tanah "); Serial.print(i); Serial.print(" : "); Serial.println(pin);
    } else {
      Serial.print("Invalid pin untuk sensor tanah "); Serial.print(i); Serial.println(".");
    }
  }
}

void setup() {
  Serial.begin(115200);
 // connectWiFi();
   WiFiManager wifiManager;

  // // Mengatur timeout (opsional)
  // wifiManager.setTimeout(60); // 30 detik timeout

  // Memulai konfigurasi WiFi
  if (!wifiManager.autoConnect("smart-farm-server", "zerudev09")) {
    Serial.println("Gagal terhubung, rebooting...");
    delay(3000);
    ESP.restart();  
  }

  Serial.println("Terhubung!");
  Serial.print("SSID: ");
  Serial.println(WiFi.SSID());
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());

  URL = fb.getString("config/server_ip");
  Serial.print(fb.getString("config/server_ip"));
  
  // DHT sensor initialization
  dht11.begin();
  
  // Get soil sensor pins and initialize them
  getSoilPins();
}

void loop() {
  // if (WiFi.status() != WL_CONNECTED) {
  //   connectWiFi();
  // }

  // Read data from DHT sensor
  Load_DHT_Data();

  // Read soil moisture
  for (int i = 0; i < MAX_SOIL_SENSORS; i++) {
    if (soilPins[i] > 0) {
      int sensor_analog = analogRead(soilPins[i]);
      moisture[i] = 100 - ((sensor_analog / 4095.0) * 100); // Konversi nilai soil moisture
      Serial.printf("Soil Moisture Sensor %d - Moisture: %d%%\n", i + 1, moisture[i]);
    }
  }

  // Format data for POST request
  String postData = formatPostData();

  HTTPClient http;
  http.begin(URL + "postDataSensor.php");
  http.addHeader("Content-Type", "application/x-www-form-urlencoded");
  
  int httpCode = http.POST(postData);
  String payload = http.getString();

  Serial.print("URL : "); Serial.println(URL); 
  Serial.print("Data: "); Serial.println(postData);
  Serial.print("httpCode: "); Serial.println(httpCode);
  Serial.print("payload : "); Serial.println(payload);
  Serial.println("--------------------------------------------------");
  delay(3000);
}

void Load_DHT_Data() {
  // Baca data dari sensor DHT11
  temperature = dht11.readTemperature();
  humidity = dht11.readHumidity();
  
  if (isnan(temperature) || isnan(humidity)) {
    Serial.println("Failed to read from DHT sensor!");
    temperature = 0.0;
    humidity = 0.0;
  } else {
    Serial.printf("DHT Sensor - Temperature: %.2f °C, Humidity: %.2f %%\n", temperature, humidity);
  }
}

String formatPostData() {
  String postData = "temperature=" + String(temperature, 2);
  postData += "&humidity=" + String(humidity, 2);

  // Tambahkan data soil moisture ke POST request
  for (int i = 0; i < MAX_SOIL_SENSORS; i++) {
    if (soilPins[i] > 0) {
      postData += "&moisture" + String(i + 1) + "=" + String(moisture[i]);
    }
  }

  return postData;
}

void connectWiFi() {
  WiFi.mode(WIFI_OFF);
  delay(1000);
  WiFi.mode(WIFI_STA); // Hide as a WiFi hotspot
  WiFi.begin(ssid, password);
  Serial.println("Connecting to WiFi");
  
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
    
  Serial.print("Connected to: "); Serial.println(ssid);
  Serial.print("IP address: "); Serial.println(WiFi.localIP());
}
