#include <WiFi.h>
#include <HTTPClient.h>
#include <WiFiClientSecure.h>   
#include <LiquidCrystal_I2C.h>
#include <Wire.h> 


// WiFi credentials
const char* ssid = "zeru"; 
const char* password = "zeruIOT09"; 

LiquidCrystal_I2C lcd(0x27,16,2);

void setup() {
  Serial.begin(115200);
  connectWiFi();

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
  }

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


// lcd system
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
