#include <WiFi.h>
#include <HTTPClient.h>
#include <WiFiClientSecure.h>   
#include <LiquidCrystal_I2C.h>
#include <Wire.h> 


// WiFi credentials
const char* ssid = "zeru"; 
const char* password = "zeruIOT09";
String URL = "http://192.168.109.60/smart-farm/config/"; 
const int MAX_RELAY_PINS = 10; 
int relayPumpPins[MAX_RELAY_PINS] = {0};
int relayFanPins[MAX_RELAY_PINS] = {0};
int espLed = 2;

LiquidCrystal_I2C lcd(0x27,16,2);


// Fungsi untuk mendapatkan pin soil sensor dari server
void getRelayPumpPins() {
  HTTPClient http;
  for (int i = 1; i <= MAX_RELAY_PINS; i++) {
    String url = URL + "getRelayPins.php?pump=" + i;
    http.begin(url);
    int httpCode = http.GET();
    if (httpCode > 0) {
      String payload = http.getString();
      Serial.print("Payload for pump "); Serial.print(i); Serial.print(": "); Serial.println(payload);

      int pin = payload.toInt(); // Konversi payload ke integer
      if (pin > 0) {
        relayPumpPins[i - 1] = pin; // Simpan nilai pin
        pinMode(pin, OUTPUT); // Set pin sebagai input
        digitalWrite(pin, HIGH);
      } else {
        Serial.print("Invalid pin for soil sensor "); Serial.print(i); Serial.println(".");
      }
    } else {
      Serial.print("Error code: ");
      Serial.println(httpCode);
    }
    http.end();
  }
}
void getRelayFanPins() {
  HTTPClient http;
  for (int i = 1; i <= MAX_RELAY_PINS; i++) {
    String url = URL + "getRelayPins.php?fan=" + i;
    http.begin(url);
    int httpCode = http.GET();
    if (httpCode > 0) {
      String payload = http.getString();
      Serial.print("Payload for fan "); Serial.print(i); Serial.print(": "); Serial.println(payload);

      int pin = payload.toInt(); // Konversi payload ke integer
      if (pin > 0) {
        relayFanPins[i - 1] = pin; // Simpan nilai pin
        pinMode(pin, OUTPUT); // Set pin sebagai input
        digitalWrite(pin, HIGH);
      } else {
        Serial.print("Invalid pin for soil sensor "); Serial.print(i); Serial.println(".");
      }
    } else {
      Serial.print("Error code: ");
      Serial.println(httpCode);
    }
    http.end();
  }
}

// get status pump
void getPumpStatus(int pumpNumber) {
  delay(1000);
  HTTPClient http;
  String urlFix = URL + "getDataRelayEsp.php?pump=" + String(pumpNumber);
  http.begin(urlFix);
  int httpCode = http.GET();
  int pinsPump = relayPumpPins[pumpNumber - 1];
  
  if (httpCode > 0) {
    String payload = http.getString();
    Serial.println("Status pump" + String(pumpNumber) + ": " + payload);
    int status = payload.toInt(); // ubah string menjadi integer
    if (status == 1) {
      digitalWrite(pinsPump, LOW); // Mengaktifkan relay (ON)
    } else if (status == 0) {
      digitalWrite(pinsPump, HIGH); // Mematikan relay (OFF)
    }
  } else {
      Serial.println("Error on HTTP request");
    }
    http.end();
}
void getFanStatus(int fanNumber) {
  delay(1000);
  HTTPClient http;
  String urlFix = URL + "getDataRelayEsp.php?fan=" + String(fanNumber);
  http.begin(urlFix);
  int httpCode = http.GET();
  int pinsFan = relayFanPins[fanNumber - 1];
  
  if (httpCode > 0) {
    String payload = http.getString();
    Serial.println("Status pump" + String(fanNumber) + ": " + payload);
    int status = payload.toInt(); // ubah string menjadi integer
    if (status == 1) {
      digitalWrite(pinsFan, LOW); // Mengaktifkan relay (ON)
    } else if (status == 0) {
      digitalWrite(pinsFan, HIGH); // Mematikan relay (OFF)
    }
  } else {
      Serial.println("Error on HTTP request");
    }
    http.end();
}

void setup() {
  Serial.begin(115200);
  connectWiFi();

  getRelayPumpPins();
  getRelayFanPins();

  pinMode(espLed, OUTPUT);
  digitalWrite(espLed, LOW);

  lcd.init();
  lcd.backlight();
  lcd.setCursor(0, 0);
  lcd.print("Wifi Connected !");
  delay(500);
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Loading");
  animateLoading(2);
  teksWelcomingLcd("192.168.109.60");
  lcd.clear();
}

void loop() {
  if (WiFi.status() != WL_CONNECTED) {
    connectWiFi();
    digitalWrite(espLed, LOW);
  }
  getPumpStatus(1);
  getFanStatus(1);
  displayValueLcd(1);
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
    digitalWrite(espLed, LOW);
  }
    
  Serial.print("Connected to: "); Serial.println(ssid);
  Serial.print("IP address: "); Serial.println(WiFi.localIP());
  digitalWrite(espLed, HIGH);
}


// lcd system
void displayValueLcd(int soilPins) {
  delay(1000);
  lcd.setCursor(0,0);
  lcd.print("Temp     : ");
  lcd.setCursor(0,1);
  lcd.print("Moisture : ");
  HTTPClient http;
  http.begin(URL + "getDataSensorEsp.php?moisture=" + String(soilPins));
  int httpCode = http.GET() ;
  String payload = http.getString();

  if (httpCode > 0) {
    lcd.setCursor(11,1);
    lcd.print(payload + "%");
  } else {
    lcd.setCursor(11,1);
    lcd.print("error");
  }
  http.end();

  http.begin(URL + "getDataSensorEsp.php?temperature");
  int httpCodeTemp = http.GET() ;
  String payloadTemp = http.getString();

  if (httpCodeTemp > 0) {
    lcd.setCursor(11,0);
    lcd.print(payloadTemp + "C");
  } else {
    lcd.setCursor(11,0);
    lcd.print("error");
  }
  http.end();
}
void animateLoading(int repeats) {
  for (int r = 0; r < repeats; r++) {
    for (int i = 0; i < 10; i++) {
      lcd.setCursor(i, 1);
      lcd.print(".");
      delay(200);
    }
    lcd.setCursor(0, 1);
    lcd.print("          ");
    delay(200);
  }
    lcd.clear();
    delay(500);
}

void teksWelcomingLcd(String ipWeb) {
  const char* welcomeText = "WELCOME";
  const char* smartFarmText = "TO SMART FARM";

  // Menampilkan teks "WELCOME" per karakter
  lcd.setCursor(4, 0);
  for (int i = 0; welcomeText[i] != '\0'; i++) {
    lcd.print(welcomeText[i]);
    delay(100); // Jeda 500ms untuk setiap karakter
  }

  delay(1000); // Jeda 1 detik sebelum menampilkan baris berikutnya

  // Menampilkan teks "TO SMART FARM" per karakter
  lcd.setCursor(1, 1);
  for (int i = 0; smartFarmText[i] != '\0'; i++) {
    lcd.print(smartFarmText[i]);
    delay(100); // Jeda 500ms untuk setiap karakter
  } 

  delay(5000);
  lcd.clear();
  delay(1000);
  lcd.setCursor(0,0);
  lcd.print("Web Controller : ");
  
  lcd.setCursor(0,1);
  lcd.print(ipWeb);
  delay(5000);

  lcd.clear();
}
