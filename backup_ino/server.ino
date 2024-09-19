#include <WiFi.h>
#include <HTTPClient.h>

#include <DHT.h> 
#define DHTPIN 19 //D19 
#define DHTTYPE DHT11 
#define SOILPIN 34 //D34
DHT dht11(DHTPIN, DHTTYPE); 

// url hosting file
String URL = "http://192.168.109.60/smart-farm/config/db.php"; 

const char* ssid = "zeru"; 
const char* password = "zeruIOT09"; 

float temperature = 0.0;
float humidity = 0.0;
int moisture = 0;

void setup() {
  Serial.begin(115200);

  pinMode(SOILPIN, INPUT);

  dht11.begin(); 
  connectWiFi();
}

void loop() {
  if(WiFi.status() != WL_CONNECTED) {
    connectWiFi();
  }

  Load_DHT11_Data();
  int sensor_analog = analogRead(SOILPIN);
  moisture = 100 - ((sensor_analog / 4095.0) * 100);
  
  // Format data with two decimal places
  String postData = "temperature=" + String(temperature, 2) + "&humidity=" + String(humidity, 2) + "&moisture=" + String(moisture);
  
  HTTPClient http;
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
  // Baca data dari sensor
  temperature = dht11.readTemperature(); // Celsius
  humidity = dht11.readHumidity();
  
  // Check if any reads failed
  if (isnan(temperature) || isnan(humidity)) {
    Serial.println("Failed to read from DHT sensor!");
    temperature = 0.0;
    humidity = 0.0;
  } else {
    Serial.printf("Temperature: %.2f °C\n", temperature);
    Serial.printf("Humidity: %.2f %%\n", humidity);
  }
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
