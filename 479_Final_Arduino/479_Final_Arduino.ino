/*
  SparkFun Si7021 Breakout Example
  Joel Bartlett @ SparkFun Electronics
  Original Creation Date: May 18, 2015
  Updated November 28th, 2023
  This sketch prints the temperature and humidity to the Serial port.

  Hardware Connections:
      Si7021 ------------- Arduino
      (-) ------------------- GND
      (+) ------------------- 3.3V (VCC)
       CL ------------------- SCL
       DA ------------------- SDA

  This code is beerware; if you see me (or any other SparkFun
  employee) at the local, and you've found our code helpful,
  please buy us a round!
  Distributed as-is; no warranty is given.
*/

#include "SparkFun_Si7021_Breakout_Library.h" //http://librarymanager/All#SparkFun_Si7021
#include <Wire.h>

SI7021 myHumidity;
// Pin Definitions
const int leftFSR = A0;    // Left FSR
const int rightFSR = A1;   // Right FSR
const int buzzerPin = 3;   // Buzzer
const int redLEDPin = 5;   // Red LED
const int blueLEDPin = 9;   // blue LED
const int yellowLEDPin = 6;   // yellow LED

// Threshold for detecting a press
const int threshold = 100; // Adjust this value based on your FSR sensitivity


void setup()
{
  Serial.begin(115200);
  delay(250);
  pinMode(buzzerPin, OUTPUT); // Set buzzer as output
  pinMode(redLEDPin, OUTPUT); // Set LED as output
  pinMode(blueLEDPin, OUTPUT); // Set LED as output
  pinMode(yellowLEDPin, OUTPUT); // Set LED as output

  Serial.println("SparkFun Si7021 Example");
  Serial.print("Humidity:");

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
  // Measure Relative Humidity from the Si7021
  float humidity = myHumidity.getRH();

  Serial.print("Humidity:");
  Serial.print(humidity, 1);
  Serial.print("%, ");

  // Measure Temperature from the Si7021
  float tempF = myHumidity.getTemperatureF();

  // Temperature is measured every time RH is requested.
  // You can also read the previous reading with getPreviousTemperature()

  Serial.print("Temperature:");
  Serial.print(tempF, 2);
  Serial.print("F, ");

  Serial.println();

  // Read FSR values
  int leftFSRValue = analogRead(leftFSR);
  int rightFSRValue = analogRead(rightFSR);

  // Debugging
  Serial.print("Left FSR: ");
  Serial.print(leftFSRValue);
  Serial.print(" | Right FSR: ");
  Serial.println(rightFSRValue);

  // Check if either FSR is pressed
  if (leftFSRValue > threshold || rightFSRValue > threshold) {
    digitalWrite(buzzerPin, HIGH); // Turn on buzzer
    digitalWrite(yellowLEDPin, HIGH); // Turn on yellow LED
  } else {
    digitalWrite(buzzerPin, LOW);  // Turn off buzzer
    digitalWrite(yellowLEDPin, LOW);  // Turn off yellow LED
  }

    // Check if either FSR is pressed
  if (humidity > 35 ) {
    digitalWrite(buzzerPin, HIGH); // Turn on buzzer
    digitalWrite(blueLEDPin, HIGH); // Turn on blue LED
  } else {
    digitalWrite(buzzerPin, LOW);  // Turn off buzzer
    digitalWrite(blueLEDPin, LOW);  // Turn off blue LED
  }

      // Check if either FSR is pressed
  if (tempF > 90 ) {
    digitalWrite(buzzerPin, HIGH); // Turn on buzzer
    digitalWrite(redLEDPin, HIGH); // Turn on red LED
  } else {
    digitalWrite(buzzerPin, LOW);  // Turn off buzzer
    digitalWrite(redLEDPin, LOW);  // Turn off red LED
  }

  // delay(50); // Small delay to prevent excessive buzzing

  delay(1000);
}
