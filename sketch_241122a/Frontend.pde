


void mousePressed() {
  // Makes sure these buttons cant be pressed on another screen
  if(appState == 0){ 
    // Check if "View Temperature Data" button is clicked
    if (tempButton.isClicked(mouseX, mouseY)){
      appState = 3;
    }
    // Check if "View Humidity Data" button is clicked
    if (humidityButton.isClicked(mouseX, mouseY)){
      appState = 4;
    }  
  }
  // Check if "Summary" button is clicked
  if (summaryButton.isClicked(mouseX, mouseY)) {
    appState = 0;
  }
  // Check if "Alerts" button is clicked
  if (alertsButton.isClicked(mouseX, mouseY)) {
    appState = 1;
  }
  // Check if "History" button is clicked
  if (historyButton.isClicked(mouseX, mouseY)) {
    appState = 2;
  }
  if(appState == 2){
    // Handle left button
    if (mouseX > calendarX - 40 && mouseX < calendarX - 10 &&
        mouseY > calendarY + calendarHeight / 2 - 20 && mouseY < calendarY + calendarHeight / 2 + 20) {
      currentMonthIndex = (currentMonthIndex - 1 + months.length) % months.length;
    }
  
    // Handle right button
    if (mouseX > calendarX + calendarWidth + 10 && mouseX < calendarX + calendarWidth + 40 &&
        mouseY > calendarY + calendarHeight / 2 - 20 && mouseY < calendarY + calendarHeight / 2 + 20) {
      currentMonthIndex = (currentMonthIndex + 1) % months.length;
    }
  }
  
}
