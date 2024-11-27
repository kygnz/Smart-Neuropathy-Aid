import processing.serial.*;
Serial myPort;


int appState = 0;  // 0 = Summary, 1 = Browse
MainButton summaryButton;
MainButton alertsButton;
MainButton historyButton;

String inputString = ""; // Variable to store incoming data
//List<Float> floatList = new ArrayList<>();
ArrayList<Float> temperatureData = new ArrayList<>();
ArrayList<Float> humidityData = new ArrayList<>();
int startTime;
//float[] temperatureData; // Array to hold temperature data
//float[] humidityData ;    // Array to hold humidity data



void setup() {
  size(430, 770);
  myPort = new Serial(this, Serial.list()[9], 115200); // Connect to Arduino
  myPort.bufferUntil('\n');  
  frontendSetup();
  // Initialize Navigation buttons
  summaryButton = new MainButton(0, height - 50, width / 3, 50, "Summary", true);
  alertsButton = new MainButton(width / 3, height - 50, width / 3, 50, "Alerts", false);
  historyButton = new MainButton(width / 3 * 2, height - 50, width / 3, 50, "History", false);
  startTime = millis();
  // Example alerts - HARDCODED FOR NOW
  alerts.add(new Alert("Temperature:"," High temperature detected! 90 F" ,"11:30 AM"));
  alerts.add(new Alert("Pressure:"," Excess pressure on foot detected! 300 FSR", " 11:45 AM"));
  alerts.add(new Alert("Humidity: "," High humidity levels detected! 35 %" ,"12:00 PM"));
  
  
  // Populate alerts (true = alert, false = no alert) HARDCODED FOR NOW
  // maybe add some hardcoded alerts to demonstrate functionality
  // along with our real data
  alertsCalendar.put("September-10", true);
  alertsCalendar.put("September-15", false);
  alertsCalendar.put("October-5", true);
  alertsCalendar.put("November-20", true);
  alertsCalendar.put("November-23", false); // Today, no alert
  
  summarySetup();
  
}

void draw() {
  background(240);  // Light gray background

  // Render based on appState
  if (appState == 0) {
    drawSummaryScreen();
    // toggle navigation buttons
    summaryButton.isPressed = true;
    alertsButton.isPressed = false;
    historyButton.isPressed = false;
  } 
  else if (appState == 1) {
    displayAlertsScreen(alerts);
    // toggle navigation buttons
    summaryButton.isPressed = false;
    alertsButton.isPressed = true;
    historyButton.isPressed = false;
  }
  else if (appState == 2) {
    drawHistoryScreen();
    // toggle navigation buttons
    summaryButton.isPressed = false;
    alertsButton.isPressed = false;
    historyButton.isPressed = true;
  }
  else if (appState == 3) {
     drawTempScreen();
  }
  else if (appState == 4) {
    drawHumidityScreen();
  }
  
  // Draw navigation buttons
  summaryButton.display();
  alertsButton.display();
  historyButton.display();
 
}


void serialEvent(Serial myPort) {
  inputString = myPort.readStringUntil('\n'); // Read the data
  if (inputString != null) {
    inputString = trim(inputString);          // Remove extra spaces
    if (inputString.startsWith("Humidity:")) {
      // Parse the data
      try {
        String[] parts = split(inputString, ", ");
        float humidity = float(split(parts[0], ":")[1].replace('%', ' '));
        float temperature = float(split(parts[1], ":")[1].replace('F', ' '));
        //println(humidity);
        //println(temperature);
        temperatureData.add( temperature);
        humidityData.add(humidity);
     
       
      } catch (Exception e) {
        println("Error parsing data: " + e.getMessage());
      }
    } else  if (inputString.startsWith("Alert:")) {
      try {
        println(inputString);
        // Example: "Alert: Temp: 75.78 at 10:39:10"
        String[] parts = split(inputString, ": ");
        println(parts[2]);
        String type = parts[1];     // "Temp", "Fsr", or "Humidity"
        String value = parts[2]; // Extract the value
        String time = parts[3].split(" at ")[1]; // Extract the timestamp
        
        // Create a new Alert object and add it to the list
        alerts.add(new Alert(type, value, time));
        
        // Limit the number of stored alerts
        if (alerts.size() > 50) { 
          alerts.remove(0); // Remove the oldest alert to maintain size
        }
      } catch (Exception e) {
        println("Error parsing alert: " + e.getMessage());
      }
    }
  }
  
  
  //String input = myPort.readStringUntil('\n');
  //if (input != null) {
  //  input = trim(input);
  //  receiveAlert(input);
  //}
}


// helper function to recieve an alert
//void receiveAlert(String rawData) {
//  String[] parts = split(rawData, "|");
//  if (parts.length == 4 && parts[0].equals("ALERT")) {
//    alerts.add(new Alert(parts[1], parts[2], parts[3]));
//  }
//}
