#include <WiFi.h>
#include <HTTPClient.h>
#include <DHT.h>

#define DHTTYPE DHT11 
#define SOILPIN 34 //D34

// URL hosting file
String URL = "http://192.168.109.60/smart-farm/config/"; 
String URLGetSensor = "http://192.168.109.60/smart-farm/config/getDevice.php?";

// WiFi credentials
const char* ssid = "zeru"; 
const char* password = "zeruIOT09"; 

// Arrays to store pin numbers for DHT sensors and soil sensors
int dhtPins[10] = {0}; // Array for DHT sensor pins
int soilPins[10] = {0}; // Array for soil sensor pins

// Variables for sensor data
float temperature[10] = {0.0}; // Array for storing temperatures from DHT sensors
float humidity[10] = {0.0};    // Array for storing humidity from DHT sensors
int moisture = 0;

// Array to hold DHT objects
DHT* dhtSensors[10];

void getDhtPins() {
  HTTPClient http;
  for (int i = 1; i <= 10; i++) {
    String url = URLGetSensor + "dht=" + i;
    http.begin(url);
    int httpCode = http.GET();
    if (httpCode > 0) {
      String payload = http.getString();
      Serial.print("Payload for dht"); Serial.print(i); Serial.print(": "); Serial.println(payload);

      int pin = payload.toInt(); // Convert payload to integer
      if (pin > 0) {
        dhtPins[i - 1] = pin; // Store pin value
        dhtSensors[i - 1] = new DHT(pin, DHTTYPE); // Create new DHT object
        dhtSensors[i - 1]->begin(); // Initialize the sensor
      } else {
        Serial.print("Invalid pin for dht"); Serial.print(i); Serial.println(".");
      }
    } else {
      Serial.print("Error code: ");
      Serial.println(httpCode);
    }
    http.end();
  }
}

void setup() {
  Serial.begin(115200);
  connectWiFi();
  
  // Get DHT sensor pins and initialize them
  getDhtPins();
  
  // Initialize soil sensors
  for (int i = 0; i < 10; i++) {
    pinMode(soilPins[i], INPUT); // Initialize soil sensor pins
  }
}

void loop() {
  if (WiFi.status() != WL_CONNECTED) {
    connectWiFi();
  }

  // Read data from all DHT sensors
  for (int i = 0; i < 10; i++) {
    if (dhtSensors[i] != nullptr) {
      Load_DHT_Data(i);
    }
  }

  // Read soil moisture
  int sensor_analog = analogRead(SOILPIN);
  moisture = 100 - ((sensor_analog / 4095.0) * 100);

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
  delay(5000);
}

void Load_DHT_Data(int index) {
  // Read data from a DHT sensor based on index
  if (dhtSensors[index] != nullptr) {
    float temp = dhtSensors[index]->readTemperature();
    float hum = dhtSensors[index]->readHumidity();
  
    if (isnan(temp) || isnan(hum)) {
      Serial.printf("Failed to read from DHT sensor at pin %d!\n", dhtPins[index]);
      temperature[index] = 0.0;
      humidity[index] = 0.0;
    } else {
      temperature[index] = temp;
      humidity[index] = hum;
      Serial.printf("DHT at pin %d - Temperature: %.2f °C, Humidity: %.2f %%\n", dhtPins[index], temp, hum);
    }
  }
}

String formatPostData() {
  String postData = "";
  for (int i = 0; i < 10; i++) {
    if (dhtSensors[i] != nullptr) {
      postData += "temperatureDht" + String(i + 1) + "=" + String(temperature[i], 2);
      postData += "&humidityDht" + String(i + 1) + "=" + String(humidity[i], 2);
      if (i < 9) {
        postData += "&";
      }
    }
  }

  // Add soil moisture data
  postData += "&moisture=" + String(moisture);

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
