import processing.serial.*;
Serial myPort;


int appState = 0;  // 0 = Summary, 1 = Browse
MainButton summaryButton;
MainButton alertsButton;
MainButton historyButton;


void setup() {
  size(430, 770);
  // Initialize Navigation buttons
  summaryButton = new MainButton(0, height - 50, width / 3, 50, "Summary", true);
  alertsButton = new MainButton(width / 3, height - 50, width / 3, 50, "Alerts", false);
  historyButton = new MainButton(width / 3 * 2, height - 50, width / 3, 50, "History", false);
  
  // Example alerts - HARDCODED FOR NOW
  alerts.add(new Alert("Temperature", "High temperature detected!", "11:30 AM"));
  alerts.add(new Alert("Pressure", "Excess pressure on foot detected!", "11:45 AM"));
  alerts.add(new Alert("Humidity", "High humidity levels detected!", "12:00 PM"));
  
  
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
    displayAlertsScreen();
    // toggle navigation buttons
    summaryButton.isPressed = false;
    alertsButton.isPressed = true;
    historyButton.isPressed = false;
  }
  else if (appState == 2) {
    drawHistoryScreen();
    //drawCalendar();
    //drawMonthNavigation();
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
  String input = myPort.readStringUntil('\n');
  if (input != null) {
    input = trim(input);
    receiveAlert(input);
  }
}



void receiveAlert(String rawData) {
  String[] parts = split(rawData, "|");
  if (parts.length == 4 && parts[0].equals("ALERT")) {
    alerts.add(new Alert(parts[1], parts[2], parts[3]));
  }
}
