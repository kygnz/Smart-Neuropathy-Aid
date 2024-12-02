import processing.serial.*;
import java.util.HashMap;


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



void setup() {
  size(430, 770);
  myPort = new Serial(this, Serial.list()[0], 115200); // Connect to Arduino
  myPort.bufferUntil('\n');  
  frontendSetup();
  // Initialize Navigation buttons
  summaryButton = new MainButton(0, height - 50, width / 3, 50, "Summary", true);
  alertsButton = new MainButton(width / 3, height - 50, width / 3, 50, "Alerts", false);
  historyButton = new MainButton(width / 3 * 2, height - 50, width / 3, 50, "History", false);
  startTime = millis();
  
  // Example alerts - HARDCODED FOR NOW
  //alerts.add(new Alert("Temperature:"," High temperature detected! 90 F" ,"11:30 AM"));
  //alerts.add(new Alert("Pressure:"," Excess pressure on foot detected! 300 FSR", " 11:45 AM"));
  //alerts.add(new Alert("Humidity: "," High humidity levels detected! 35 %" ,"12:00 PM"));
  
  
  // Populate alerts (true = alert, false = no alert) 
  // added hardcoded alerts to demonstrate functionality
  // along with our real data
  // Populate alert history dynamically
  addAlert("September-10", "Temperature Alert: High temperature detected!");
  addAlert("September-10", "Temperature Alert: High temperature detected!");
  addAlert("September-10", "Pressure Alert: Excess pressure detected on foot!");
  addAlert("September-10", "Pressure Alert: Excess pressure detected on foot!");
  addAlert("October-5", "Pressure Alert: Excess pressure detected on foot!");
  addAlert("November-20", "Humidity Alert: High humidity detected!");
  addAlert("November-20", "Temperature Alert: High temperature detected!");
  
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
    //drawHistoryScreen();
    if (showAlertDetails) {
      drawAlertDetails();
    } else {
      drawHistoryScreen();
    }
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
      synchronized (humidityData) {
        try {
          String[] parts = split(inputString, ", ");
          float humidity = float(split(parts[0], ":")[1].replace('%', ' '));
          float temperature = float(split(parts[1], ":")[1].replace('F', ' '));
          temperatureData.add(temperature);
          humidityData.add(humidity);
        } catch (Exception e) {
          println("Error parsing data: " + e.getMessage());
        }
      }
      
    } else  if (inputString.startsWith("Alert:")) {
      synchronized (alerts) {
        try {
          println(inputString);
          String[] parts = split(inputString, ": ");
          String type = parts[1].trim();
          String remaining = parts[2].trim();
          int atIndex = remaining.lastIndexOf(" at ");
          if (atIndex == -1) {
            println("Error: Missing 'at' in alert string.");
            return;
          }

          String value = remaining.substring(0, atIndex).trim();
          String time = remaining.substring(atIndex + 4).trim();

          alerts.add(new Alert(type, value, time));

          // Add alert to the calendar
          addAlert("December-3", type + ": " + value);

          showAlert = true;
          lastAlertTime = millis();

          // Limit alerts to 100
          while (alerts.size() > 100) {
            alerts.remove(0);
          }
        } catch (Exception e) {
          println("Error parsing alert: " + e.getMessage());
        }
      }
      
    }
  }
  
}
