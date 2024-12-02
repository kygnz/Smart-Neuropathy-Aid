/* THIS FILE HANDLES THE HISTORY SCREEN, WHICH DISPLAYS 
  A CALENDAR OF ALERT HISTORY */


// Calendar variables
int calendarX = 65;         // X position of the calendar
int calendarY = 150;        // Y position of the calendar
int calendarWidth = 300;    // Width of the calendar
int calendarHeight = 350;   // Height of the calendar
int circleSize = 30;        // Diameter of day circles
int spacing = 10;           // Spacing between circles
color bgColor = color(250); // Background color for the calendar

// Sample data for alerts
//HashMap<String, Boolean> alertsCalendar = new HashMap<String, Boolean>();
HashMap<String, ArrayList<String>> alertsCalendar = new HashMap<String, ArrayList<String>>();

String[] months = {"September", "October", "November", "December"};
int[] daysInMonth = {30, 31, 30, 31};
int currentMonthIndex = 3;  // Start with September

// Today's date
int todayMonthIndex = 3; // November (0-based index)
int todayDate = 3;

boolean showAlertDetails = false; // Tracks if the details page is displayed
String selectedDate = "";


void drawHistoryScreen() {
  background(236);
  // Header
  fill(50);
  textAlign(CENTER, CENTER);
  textSize(34);
  text("My Health History", width / 2, height / 10);
  drawCalendar();
  drawMonthNavigation();
}


void drawCalendar() {
  // Draw calendar background
  fill(bgColor);
  noStroke();
  rect(calendarX, calendarY, calendarWidth, calendarHeight, 20);

  // Draw month title
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(20);
  text(months[currentMonthIndex], calendarX + calendarWidth / 2, calendarY + 40);

  // Draw days of the week
  String[] daysOfWeek = {"SU", "M", "T", "W", "TH", "F", "SA"};
  textSize(14);
  for (int i = 0; i < daysOfWeek.length; i++) {
    fill(0);
    text(daysOfWeek[i], calendarX + 30 + i * (circleSize + spacing), calendarY + 80);
  }

  // Draw days of the month
  int startX = calendarX + 30;
  int startY = calendarY + 120;
  int x = startX, y = startY;

  for (int day = 1; day <= daysInMonth[currentMonthIndex]; day++) {
    String key = months[currentMonthIndex] + "-" + day;

    if (currentMonthIndex > todayMonthIndex || (currentMonthIndex == todayMonthIndex && day > todayDate)) {
      fill(200); // Light grey for future dates
    //}// else if (currentMonthIndex == todayMonthIndex && day == todayDate) {
    //  fill(42, 157, 143); // Highlight today
    } else if (alertsCalendar.containsKey(key)) {
      fill(231, 111, 81); // Red for alert days
    } else {
      fill(134, 203, 146); // Green for no-alert days
    }
    //// Determine fill color
    //if (currentMonthIndex > todayMonthIndex || (currentMonthIndex == todayMonthIndex && day > todayDate)) {
    //  fill(200); // Light grey for future dates
    //} else if (currentMonthIndex == todayMonthIndex && day == todayDate) {
    //  fill(42, 157, 143); //Dark for today
    //} else if (alertsCalendar.containsKey(months[currentMonthIndex] + "-" + day) && alertsCalendar.get(months[currentMonthIndex] + "-" + day)) {
    //  fill(231, 111, 81); // Red for days with alerts
    //} else {
    //  fill(134, 203, 146); // Green for days without alerts
    //}

    // Draw circle for the day
    ellipse(x, y, circleSize, circleSize);

    // Draw the day number
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(12);
    text(day, x, y);

    // Move to the next position
    x += circleSize + spacing;
    if ((day + 1) % 7 == 1) { // Start a new row after Saturday
      x = startX;
      y += circleSize + spacing;
    }
  }
}


void drawMonthNavigation() {
  // Left button
  fill(200);
  rect(calendarX - 40, calendarY + calendarHeight / 2 - 20, 30, 40, 10);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("<", calendarX - 25, calendarY + calendarHeight / 2);

  // Right button
  fill(200);
  rect(calendarX + calendarWidth + 10, calendarY + calendarHeight / 2 - 20, 30, 40, 10);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(16);
  text(">", calendarX + calendarWidth + 25, calendarY + calendarHeight / 2);
}

void drawAlertDetails() {
  background(236);

  // Back button
  fill(200);
  rect(10, 10, 100, 40, 10);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("Back", 60, 30);

  // Display alerts for the selected date
  if (alertsCalendar.containsKey(selectedDate)) {
    fill(50);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("Alerts on " + selectedDate, width / 2, height / 10);

    textSize(16);
    ArrayList<String> alerts = alertsCalendar.get(selectedDate);
    for (int i = 0; i < alerts.size(); i++) {
      text(alerts.get(i), width / 2, height / 10 * 2 + i * 30);
    }
  }
}

void addAlert(String date, String alert) {
  if (!alertsCalendar.containsKey(date)) {
    alertsCalendar.put(date, new ArrayList<String>());
  }
  alertsCalendar.get(date).add(alert);
}

String getCurrentDate() {
  int day = day();      // Get the current day
  int month = month();  // Get the current month (1 = January, 12 = December)
  String monthName = months[month - 1]; // Use the `months` array
  return monthName + "-" + day;         // Format: "Month-Day"
}
