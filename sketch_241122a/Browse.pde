/* THIS FILE HANDLES THE HISTORY SCREEN, WHICH DISPLAYS 
  A MENU OF ALL POSSIBLE FUNCTIONALITIES OF THIS APP */


// Calendar variables
int calendarX = 65;         // X position of the calendar
int calendarY = 150;        // Y position of the calendar
int calendarWidth = 300;    // Width of the calendar
int calendarHeight = 350;   // Height of the calendar
int circleSize = 30;        // Diameter of day circles
int spacing = 10;           // Spacing between circles
color bgColor = color(250); // Background color for the calendar

// Sample data for alerts
HashMap<String, Boolean> alertsCalendar = new HashMap<String, Boolean>();
String[] months = {"September", "October", "November", "December"};
int[] daysInMonth = {30, 31, 30, 31};
int currentMonthIndex = 0;  // Start with September

// Today's date
int todayMonthIndex = 2; // November (0-based index)
int todayDate = 23;


void drawHistoryScreen() {
  background(236);
  // Header
  fill(50);
  textAlign(CENTER, CENTER);
  textSize(34);
  text("My Health", width / 2, height / 10);
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
    // Determine fill color
    if (currentMonthIndex > todayMonthIndex || (currentMonthIndex == todayMonthIndex && day > todayDate)) {
      fill(200); // Light grey for future dates
    } else if (currentMonthIndex == todayMonthIndex && day == todayDate) {
      fill(42, 157, 143); //Dark for today
    } else if (alertsCalendar.containsKey(months[currentMonthIndex] + "-" + day) && alertsCalendar.get(months[currentMonthIndex] + "-" + day)) {
      fill(231, 111, 81); // Red for days with alerts
    } else {
      fill(134, 203, 146); // Green for days without alerts
    }

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
