// Variables for the temperature summary rectangle
float tRectX = 30;                  // X position of the rectangle
float tRectY = 250;                 // Y position of the rectangle
float tRectWidth = 370;             // Width of the rectangle
float tRectHeight = 100;            // Height of the rectangle
float tRectCornerRadius = 10;       // Corner radius for the rectangle

// Variables for the text inside the rectangle
float tTextX = 77;                  // X position of the text
float tTextY = 270;                 // Y position of the text
String tLabel = "Temperature";      // Text content for the label
int tTextSize = 14; 
 
 // Variables for the temperature summary rectangle
float hRectX = 30;                  // X position of the rectangle
float hRectY = 400;                 // Y position of the rectangle
float hRectWidth = 370;             // Width of the rectangle
float hRectHeight = 100;            // Height of the rectangle
float hRectCornerRadius = 10;       // Corner radius for the rectangle

// Variables for the text inside the rectangle
float hTextX = 40;                  // X position of the text
float hTextY = 415;                 // Y position of the text
String hLabel = "Humidity";      // Text content for the label
int hTextSize = 14; 


MoreInfoButton tempButton;
MoreInfoButton humidityButton;

void summarySetup(){
 
  tempButton = new MoreInfoButton(tRectX, tRectY + 105, tRectWidth, tRectHeight / 2.7, "View Temperature Data");
  humidityButton = new MoreInfoButton(hRectX, hRectY + 105, hRectWidth, hRectHeight / 2.7, "View Humidity Data");
  
}

void drawSummaryScreen() {
  // Summary screen content
  fill(50);
  textAlign(CENTER, CENTER);
  textSize(34);
  text("Welcome, Ky", width / 2, height / 10);
  
  // display current alerts
  textSize(24);
  text("No Alerts - looking good!", width / 2, height / 10 * 2.5);
  
  
  // Display temperature summary
  fill(100, 150, 200);              // Rectangle fill color
  noStroke();                       
  rect(tRectX, tRectY, tRectWidth, tRectHeight, tRectCornerRadius);
  fill(255);                        // Text fill color
  textSize(tTextSize);
  text(tLabel, tTextX, tTextY);
  tempButton.display();
  
  
  // Display humidity summary
  fill(100, 150, 200);              // Rectangle fill color
  noStroke();                       
  rect(hRectX, hRectY, hRectWidth, hRectHeight, hRectCornerRadius);
  fill(255);                        // Text fill color
  textSize(hTextSize);
  text(hLabel, hTextX, hTextY);
  humidityButton.display();
 
  
}
