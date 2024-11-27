// Variables for the temperature summary rectangle
float tRectX = 30;                  // X position of the rectangle
float tRectY = 250;                 // Y position of the rectangle
float tRectWidth = 370;             // Width of the rectangle
float tRectHeight = 100;            // Height of the rectangle
float tRectCornerRadius = 10;       // Corner radius for the rectangle

// Variables for the text inside the rectangle
float tTextX = 80;                  // X position of the text
float tTextY = 265;                 // Y position of the text
String tLabel = "Temperature";      // Text content for the label
int tTextSize = 14; 
String display_data="Loading..";
 
 // Variables for the temperature summary rectangle
float hRectX = 30;                  // X position of the rectangle
float hRectY = 400;                 // Y position of the rectangle
float hRectWidth = 370;             // Width of the rectangle
float hRectHeight = 100;            // Height of the rectangle
float hRectCornerRadius = 10;       // Corner radius for the rectangle

// Variables for the text inside the rectangle
float hTextX = 40;                  // X position of the text
float hTextY = 420;                 // Y position of the text
String hLabel = "Humidity";      // Text content for the label
int hTextSize = 14; 


MoreInfoButton tempButton;
MoreInfoButton humidityButton;

void summarySetup(){
 
  tempButton = new MoreInfoButton(tRectX, tRectY + 105, tRectWidth, tRectHeight / 2.7, "View Temperature Data");
  humidityButton = new MoreInfoButton(hRectX, hRectY + 105, hRectWidth, hRectHeight / 2.7, "View Humidity Data");
  
}

void drawSummaryScreen() {
  //background(239, 235, 239);
  background(236);
  // Summary screen content
  fill(0, 48, 73);
  textAlign(CENTER, CENTER);
  textSize(34);
  text("Welcome", width / 2, height / 10);
  
  // display current alerts
  textSize(24);
  text("No Alerts - looking good!", width / 2, height / 10 * 2.5);
  
  
  // Display temperature summary
  fill(250);              // Rectangle fill color
  noStroke();                       
  rect(tRectX, tRectY, tRectWidth, tRectHeight, tRectCornerRadius);
  fill(0, 48, 73);                        // Text fill color
  textSize(tTextSize);
  text(tLabel, tTextX, tTextY);
    textSize(54);
  if(temperatureData.size()>0){
  text(int(temperatureData.get(temperatureData.size()-1))+"° F", tTextX+70, tTextY + 45);    // replace with variable for actual data
  
  // average temperature:
  textSize(14);
    // Calculate the average
        float sum = 0.0f;
        for (Float temp : temperatureData) {
            sum += temp;
        }

        int average =int( sum / temperatureData.size());

  text("Average: " + average+"° F",tTextX +180, tTextY+70); // replace with variable for actual data
  }else{
    textSize(24);
    text("Loading...",tTextX+70, tTextY + 50); // replace with variable for actual data

  }
  tempButton.display();
  
  
  // Display humidity summary
  fill(250);              // Rectangle fill color
  noStroke();                       
  rect(hRectX, hRectY, hRectWidth, hRectHeight, hRectCornerRadius);
  fill(0, 48, 73);                       // Text fill color
  textSize(hTextSize);
  text(hLabel, hTextX, hTextY);
  textSize(54);
  if(humidityData.size()>0){
  text(humidityData.get(humidityData.size()-1)+" %", hTextX+50, hTextY+50);    // replace with variable for actual data

  // average temperature:
  textSize(14);
      // Calculate the average
        float sum = 0.0f;
        for (Float temp : humidityData) {
            sum += temp;
        }

        int average = int(sum / humidityData.size());
  text("Average: " + int(average)+" %", hTextX+180, hTextY+80); // replace with variable for actual data
  } else{
      textSize(24);
    text("Loading...",hTextX+50, hTextY+50); // replace with variable for actual data

  }
  humidityButton.display();
 
  
}
