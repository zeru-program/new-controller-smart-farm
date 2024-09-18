#include <WiFi.h>
#include <HTTPClient.h>
#include <DHT.h> 
#include <ArduinoJson.h>


#define DHTPIN 19 //D19 
#define DHTTYPE DHT11
// url hosting file
String URL = "http://localhost:5000/config/db.php"; 
const char* ssid = "zeru"; 
const char* password = "zeruIOT09"; 
int temperature = 0;
int humidity = 0;
int moisture = 0;

DHT dht11(DHTPIN, DHTTYPE); 
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
        if (data["device_name"] === "dht") {
          const char* dht = data["pin"]; 
          const char* type = data["type"];
        }
      
      // Cetak data
      Serial.print("dht pin: ");
      Serial.println(dht);
      Serial.print("type: ");
      Serial.println(type);
    }
  } else {
    Serial.print("Error code: ");
    Serial.println(httpCode);
  }
    http.end();
}

void setup() {
  Serial.begin(115200);

  dht11.begin(); 
  
  getDevice();
  
  connectWiFi();
}

void loop() {
  if(WiFi.status() != WL_CONNECTED) {
    connectWiFi();
  }

  Load_DHT11_Data();
  String postData = "temperature=" + String(temperature, 2) + "&humidity=" + String(humidity, 2) + "&moisture=" + String(moisture);
  
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


void Load_DHT11_Data() {
  //-----------------------------------------------------------
  temperature = dht11.readTemperature(); //Celsius
  humidity = dht11.readHumidity();
  //-----------------------------------------------------------
  // Check if any reads failed.
  if (isnan(temperature) || isnan(humidity)) {
    Serial.println("Failed to read from DHT sensor!");
    temperature = 0;
    humidity = 0;
  }
  //-----------------------------------------------------------
  Serial.printf("Temperature: %d °C\n", temperature);
  Serial.printf("Humidity: %d %%\n", humidity);
}

void connectWiFi() {
  WiFi.mode(WIFI_OFF);
  delay(1000);
  //This line hides the viewing of ESP as wifi hotspot
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
