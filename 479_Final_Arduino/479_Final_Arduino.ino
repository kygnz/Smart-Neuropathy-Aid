#include "SparkFun_Si7021_Breakout_Library.h"
#include <Wire.h>

SI7021 myHumidity;

// Pin Definitions
const int leftFSR = A0;    // Left FSR
const int rightFSR = A1;   // Right FSR
const int buzzerPin = 3;   // Buzzer
const int redLEDPin = 5;   // Red LED
const int blueLEDPin = 9;  // Blue LED
const int yellowLEDPin = 6; // Yellow LED
// int melody[] = []; // C4 to C5

// bool alarmActive = false;
// Threshold for detecting a press
// float temperatureThreshold = 95.0;
const int threshold = 800; // Adjust this value based on your FSR sensitivity
// float temperatureThresholdLow = 90.0; // Low-temperature threshold to stop alarm
const float humidityThreshold = 65.0;
const float temperatureThresholdHigh = 95.0;
const float temperatureThresholdLow = 90.0;
unsigned long previousMillis = 0; // Timer
unsigned long alertCooldown = 5000;
const unsigned long interval = 1000;

// Previous sensor readings
float previousHumidity = 0.0;
float previousTemperature = 0.0;
unsigned long lastAlertTime = 0;

// States for tracking alerts
bool humidityAlertActive = false;
bool temperatureAlertActive = false;

// Variables for buzzer timing
unsigned long buzzerStartTime = 0;
bool isBuzzerOn = false;

void setup()
{
  Serial.begin(115200);
  delay(250);

  pinMode(buzzerPin, OUTPUT);
  pinMode(redLEDPin, OUTPUT);
  pinMode(blueLEDPin, OUTPUT);
  pinMode(yellowLEDPin, OUTPUT);

  Serial.println("SparkFun Si7021 Example");

  Wire.begin();

  while (myHumidity.begin() == false)
  {
    Serial.println("Sensor not found. Please check wiring. Freezing...");
    while (true)
      ;
  }
  Serial.println("Humidity sensor detected");
}

void loop()
{

  // Measure Relative Humidity
  float humidity = myHumidity.getRH();

  // Measure Temperature
  float tempF = myHumidity.getTemperatureF();

  // Read FSR values
  int leftFSRValue = analogRead(leftFSR);
  int rightFSRValue = analogRead(rightFSR);

  // Get current time (mocked as millis() for now)
  unsigned long currentMillis = millis();

  // Send sensor readings
  Serial.print("Humidity:");
  Serial.print(humidity, 1);
  Serial.print("%, Temperature:");
  Serial.print(tempF, 2);
  Serial.print("F, Left FSR:");
  Serial.print(leftFSRValue);
  Serial.print(" | Right FSR:");
  Serial.println(rightFSRValue);


/*ORIGINAL VALUESSSSSSS*/
  // Check for alerts and handle LEDs/Buzzer
  // handleAlert(humidity > 65, "Humidity", "High humidity levels detected! "+String(humidity)+" %", blueLEDPin, currentMillis);
  // handleAlert(tempF > 80, "Temperature", "High temperature detected! "+String(tempF)+ " °F", redLEDPin, currentMillis);
  // handleAlert(leftFSRValue > threshold || rightFSRValue > threshold, "Pressure", "Excess pressure on foot detected! "+String(max(leftFSRValue, rightFSRValue)) +" FSR", yellowLEDPin, currentMillis);

// handleAlert(humidity > 65, "Humidity", "High humidity levels detected! "+String(humidity)+" %", blueLEDPin, currentMillis);
//   handleAlert(tempF > 95, "Temperature", "High temperature detected! "+String(tempF)+ " °F", redLEDPin, currentMillis);
//   handleAlert(leftFSRValue > threshold || rightFSRValue > threshold-250, "Pressure", "Excess pressure on foot detected! "+String(max(leftFSRValue, rightFSRValue)) +" FSR", yellowLEDPin, currentMillis);


    // Handle Humidity Alert
    if (humidity > humidityThreshold) {
      if (!humidityAlertActive || humidity > previousHumidity) {
        humidityAlertActive = true;
        handleAlert(true, "Humidity", "High humidity levels detected! " + String(humidity) + " %", blueLEDPin, currentMillis);
      }
    } else if (humidityAlertActive && humidity < previousHumidity) {
      humidityAlertActive = false;
      handleAlert(false, "Humidity", "Humidity back to safe levels: " + String(humidity) + " %", blueLEDPin, currentMillis);
    }

    // Handle Temperature Alert
    if (tempF > temperatureThresholdHigh) {
      if (!temperatureAlertActive || tempF > previousTemperature) {
        temperatureAlertActive = true;
        handleAlert(true, "Temperature", "High temperature detected! " + String(tempF) + " °F", redLEDPin, currentMillis);
      }
    } else if (temperatureAlertActive && tempF < temperatureThresholdLow) {
      temperatureAlertActive = false;
      handleAlert(false, "Temperature", "Temperature back to safe levels: " + String(tempF) + " °F", redLEDPin, currentMillis);
    }

    // handleAlert(humidity > 65, "Humidity", "High humidity levels detected! " + String(humidity) + " %", blueLEDPin, currentMillis);
    // handleAlert(tempF > 95, "Temperature", "High temperature detected! " + String(tempF) + " \u00B0F", redLEDPin, currentMillis);
    handleAlert(leftFSRValue > threshold || rightFSRValue > threshold - 250, "Pressure", "Excess pressure on foot detected! " + String(max(leftFSRValue, rightFSRValue)) + " FSR", yellowLEDPin, currentMillis);
  // if (tempF > temperatureThreshold && !alarmActive) {
  //       alarmActive = true;
  //       handleAlert(true, "Temperature", "High temperature detected! " + String(tempF) + " °F", redLEDPin, currentMillis);
  //   }

  //   // Handle cooling down (below low threshold)
  //   if (tempF < temperatureThresholdLow && alarmActive) {
  //       alarmActive = false;
  //       handleAlert(false, "Temperature", "Temperature back to safe levels: " + String(tempF) + " °F", redLEDPin, currentMillis);
  //       stopAlarm(); // Function to stop the alarm
  //   }

  // Update previous readings for comparison
  previousHumidity = humidity;
  previousTemperature = tempF;

  // Manage buzzer timeout
  manageBuzzer(currentMillis);
  delay(200);

}

void handleAlert(bool condition, String type, String value, int ledPin, unsigned long currentMillis) {
  if (condition) {
    if (currentMillis - lastAlertTime > alertCooldown) {
        Serial.print("Alert: ");
        Serial.print(type);
        Serial.print(": ");
        Serial.print(value);
        Serial.print(" at ");
        Serial.println(getFormattedTime(currentMillis));

        digitalWrite(ledPin, HIGH); // Keep LED on
        triggerBuzzer(currentMillis,type); // Turn on the buzzer for 3 seconds
        lastAlertTime = currentMillis;
    }
  } else {
    digitalWrite(ledPin, LOW); // Turn off LED
  }
}
// Function to play buzzer melody
void playBuzzer(int melody[], int length) {
  for (int i = 0; i < length; i++) {
    tone(buzzerPin, melody[i]); // Play each note
    delay(100);         // Wait for the duration
    noTone(buzzerPin);  // Stop sound before the next note
    delay(200);         // Short gap between notes
  }
}

// Function to trigger buzzer based on type
void triggerBuzzer(unsigned long currentMillis, String type) {
  if (!isBuzzerOn) {  // Only start the buzzer if it's not already active
    int melody[9];  // Declare the melody array

    if (type == "FSR") {
      melody[0] = 500;
      melody[1] = 600;
      melody[2] = 400;
      playBuzzer(melody, 3);  // Pass array and its length (3)
    }
    else if (type == "Humidity") {
      melody[0] = 400;
      melody[1] = 600;
      melody[2] = 800;
      playBuzzer(melody, 3);  // Pass array and its length (3)
    }
    else {
      melody[0] = 300;
      melody[1] = 300;
      melody[2] = 300;
      melody[3] = 500;
      melody[4] = 500;
      melody[5] = 500;
      melody[6] = 700;
      melody[7] = 700;
      melody[8] = 700;
      playBuzzer(melody, 9);  // Pass array and its length (9)
    }

    buzzerStartTime = currentMillis;
    isBuzzerOn = true;
  }
}

void manageBuzzer(unsigned long currentMillis) {
  if (isBuzzerOn && (currentMillis - buzzerStartTime >= 3000)) { // 3 seconds passed
    digitalWrite(buzzerPin, LOW);
    isBuzzerOn = false;
  }
}

String getFormattedTime(unsigned long millis) {
  unsigned long seconds = millis / 1000;
  unsigned long minutes = seconds / 60;
  unsigned long hours = minutes / 60;
  seconds = seconds % 60;
  minutes = minutes % 60;
  hours = hours % 24;

  char buffer[9];
  sprintf(buffer, "%02lu:%02lu:%02lu", hours, minutes, seconds);
  return String(buffer);
}
