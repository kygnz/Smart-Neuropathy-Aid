/* THIS FILE MANAGES THE ALERTS SCREEN */
import java.util.Iterator;

// LIST TO STORE ALERTS
ArrayList<Alert> alerts = new ArrayList<Alert>();

 // Variables for scrolling
float scrollOffset = 0; // Tracks vertical scrolling
float itemHeight = 90;  // Height of each alert (including spacing)
//int windowHeight = 400; // Visible height of the window
float totalHeight;        // Total height of the alerts list

//void alertSetup() {
//  //size(400, windowHeight);

//  //// Add test alerts
//  //for (int i = 0; i < 20; i++) {
//  //  alerts.add(new Alert("Type " + i, "Message " + i, "Time " + i));
//  //}

  
//}


void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  scrollOffset += e * 20; // Adjust scroll speed

  // Constrain scrolling to the content height
  scrollOffset = constrain(scrollOffset, 0, max(0, totalHeight - windowHeight));
}

// Displays the alerts in a scrollable list view
void displayAlertsScreen(ArrayList<Alert> alerts) {
  background(236);
  fill(0, 48, 73);
  textAlign(CENTER, CENTER);
  textSize(34);
  text("Alerts", width / 2, height / 10);
  
  totalHeight = alerts.size() * itemHeight; // Calculate total height

  if (alerts.size() == 0) {
    textAlign(CENTER, CENTER);
    fill(0, 48, 73);
    textSize(24);
    text("No alerts to display", width / 2, height / 2);
  } else {
    pushMatrix();
    translate(0, -scrollOffset); // Apply scrolling offset

    //float y = 50; // Starting y position
    //for (Alert alert : alerts) {
    //  alert.display(30, y, 375, 80);
    //  y += itemHeight; // Spacing between alerts
    //}
    float y = 130; // Starting y position
    Iterator<Alert> iterator = alerts.iterator();
    while (iterator.hasNext()) {
      Alert alert = iterator.next();
      // Safe iteration and drawing
      alert.display(30, y, width - 60, 80);
      y += itemHeight;
    }

    popMatrix();
    //if (totalHeight > windowHeight) {
      drawScrollbar();
    //}
  }
}

// Draws the scrollbar for the alerts screen
void drawScrollbar() {
  float scrollbarHeight = map(windowHeight, 0, totalHeight, 0, height);
  float scrollbarY = map(scrollOffset, 0, totalHeight - windowHeight, 0, height - scrollbarHeight);

  fill(255);
  rect(width - 10, 0, 10, height); // Background scrollbar
  fill(240);
  rect(width - 10, scrollbarY, 10, scrollbarHeight); // Scrolling thumb
}



//// displays the alerts in a list view
//void displayAlertsScreen(ArrayList<Alert> alerts) {
//  background(236);
  
//  if(alerts.size() == 0){
//    textAlign(CENTER, CENTER);
//    textSize(24);
//    text("No alerts to display", width / 2, height / 2);
//  }
//  else {
//    float y = 50; // Starting position
//    for (Alert alert : alerts) {
//      alert.display(30, y, 375, 80);
//      y += 90; // Spacing between alerts
//    }
//  }
    
//}



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
    //fill(133, 173, 166);
    fill(getColor());
    rect(x, y, w, h, 10);
    fill(255);
    textAlign(LEFT, CENTER);
    textSize(14);
    text(type + ": " + value + "\n" + "Time: " + time, x + 10, y + h / 2);
  }
  
  color getColor() {
  if (this.type.equals("Temperature")) {
    return color(216, 87, 42); // Orange
  } else if (this.type.equals("Humidity")) {
    return color(33, 158, 188); // Light blue
  } else if (this.type.equals("Pressure")) {
    return color(233, 196, 106); // Yellow
  } else {
    return color(250); // Default grayish white
  }
}
}
