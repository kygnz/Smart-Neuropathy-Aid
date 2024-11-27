/* THIS FILE MANAGES THE ALERTS SCREEN */


// LIST TO STORE ALERTS
ArrayList<Alert> alerts = new ArrayList<Alert>();

  
// displays the alerts in a list view
void displayAlertsScreen(ArrayList<Alert> alerts) {
  background(236);
  
  if(alerts.size() == 0){
    textAlign(CENTER, CENTER);
    textSize(24);
    text("No alerts to display", width / 2, height / 2);
  }
  else {
    float y = 50; // Starting position
    for (Alert alert : alerts) {
      alert.display(30, y, 375, 80);
      y += 90; // Spacing between alerts
    }
  }
    
}



// Class to manage layout and information of an alert
class Alert {
  String type;
  String value;
  String time;
  
  // constructor
  Alert(String type, String value, String time) {
    this.type = type;
    this.value = value;
    this.time = time;
  }
  
  // displays an alert styled as a panel
  void display(float x, float y, float w, float h) {
    fill(133, 173, 166);
    rect(x, y, w, h, 10);
    fill(255);
    textAlign(LEFT, CENTER);
    textSize(14);
    text(type + ": " + value + "\n" + "Time: " + time, x + 10, y + h / 2);
  }
}
