
int hWindowWidth = 440;
int hWindowHeight = 770;
int hMargin = 60;         // Space around the graph
int hGraphHeight = (hWindowHeight - (hMargin * 5)) / 4; // Same style as first graph
color hGraphColor = color(0, 119, 182);  // Blue color for the graph


void drawHumidityScreen(){
  background(236);
  // Current Temperature Section
  fill(0, 48, 73); 
  textAlign(CENTER, CENTER);
  textSize(14);
  text("Current Humidity:", width / 2, height / 10);
  textSize(54);
  if(humidityData.size()>0){
  text(humidityData.get(humidityData.size()-1)+" %", width / 2, height / 10 + 55);    // replace with variable for actual data

  // average temperature:
  textSize(14);
      // Calculate the average
        float sum = 0.0f;
        for (Float temp : humidityData) {
            sum += temp;
        }

        int average = int(sum / humidityData.size());
  text("Average: " + average+" %", width / 2, height / 10 + 95); // replace with variable for actual data
  }
  
  // display temeprature graph
  drawHumidityGraph(humidityData);
  
}
void drawHumidityGraph(ArrayList<Float> humidityData ) {
  int yBase = 270; // Top margin for the graph
  int yMax = 100;   // Maximum value on Y-axis
  int yMin = 0;  // Minimum value on Y-axis

  // Draw white background with rounded corners for the graph
  fill(255); // White background
  noStroke();
  rect(hMargin - 10, yBase - 10, hWindowWidth - hMargin * 2 + 40, hGraphHeight + 40, 20);

  // Draw title
  fill(0, 48, 73);
  textAlign(CENTER, CENTER);
  textSize(18);
  text("Humidity Data", hWindowWidth / 2, yBase - 40);

  // Draw axes
  stroke(0);
  strokeWeight(1);
  line(hMargin, yBase, hMargin, yBase + hGraphHeight);  // Y-axis
  line(hMargin, yBase + hGraphHeight, hWindowWidth - hMargin, yBase + hGraphHeight);  // X-axis

  // Draw axis labels
  fill(0, 48, 73);
  textSize(14);

  // Y-axis label
  textAlign(CENTER, CENTER);
  pushMatrix();
  translate(hMargin - 40, yBase + hGraphHeight / 2);
  rotate(-PI / 2); // Rotate the text for vertical axis label
  text("Humidity (%)", 0, 0);
  popMatrix();

  // X-axis label
  textAlign(CENTER, CENTER);
  text("Time (s)", hWindowWidth / 2, yBase + hGraphHeight + 40);

  // Draw Y-axis labels
  textAlign(RIGHT, CENTER);
  textSize(12);
  text(yMax + "%", hMargin - 10, yBase); // Top value (maximum temperature)
  text(yMin + "%", hMargin - 10, yBase + hGraphHeight); // Bottom value (minimum temperature)


  // Draw X-axis labels
  textAlign(CENTER, TOP);
  int elapsedTime = (millis() - startTime) / 1000;  // Convert to seconds
  text(elapsedTime +" sec.", windowWidth - margin, yBase + graphHeight + 10);
  //text("0", hMargin, yBase + hGraphHeight + 10); // Start of X-axis
  //text("100", hWindowWidth - hMargin, yBase + hGraphHeight + 10); // End of X-axis

  // Plot temperature data
  if (humidityData != null && humidityData.size() > 1) {
    stroke(hGraphColor); // Line color
    strokeWeight(2);
    noFill();

    beginShape();
    for (int i = 0; i < humidityData.size(); i++) {
      
      //println(humidityData);
      float x = map(i, 0, humidityData.size() - 1, hMargin, hWindowWidth - hMargin);
      float y = map(humidityData.get(i), yMin, yMax, yBase + hGraphHeight, yBase); // Invert Y-axis
      vertex(x, y);
    }
    endShape();
  } else {
    // Show placeholder text if no data is available
    fill(hGraphColor);
    noStroke();
    textAlign(CENTER, CENTER);
    text("No Data Available", hWindowWidth / 2, yBase + hGraphHeight / 2);
  }
}


//void drawHumidityGraph(){
//  int yBase = 270; // Top margin for the graph

//  // Draw white background with rounded corners for the graph
//  fill(255); // White background
//  noStroke();
//  rect(hMargin - 10, yBase - 10, hWindowWidth - hMargin * 2 + 40, hGraphHeight + 40, 20);

//  // Draw title
//  fill(0, 48, 73);
//  textAlign(CENTER, CENTER);
//  textSize(18);
//  text("Humidity Data", hWindowWidth / 2, yBase - 40);

//  // Draw axes
//  stroke(0);
//  strokeWeight(1);
//  line(hMargin, yBase, hMargin, yBase + hGraphHeight);  // Y-axis
//  line(hMargin, yBase + hGraphHeight, hWindowWidth - hMargin, yBase + hGraphHeight);  // X-axis

//  // Draw axis labels
//  fill(0, 48, 73);
//  textSize(14);

//  // Y-axis label
//  textAlign(CENTER, CENTER);
//  pushMatrix();
//  translate(hMargin - 40, yBase + hGraphHeight / 2);
//  rotate(-PI / 2); // Rotate the text for vertical axis label
//  text("Humidity (°F)", 0, 0);
//  popMatrix();

//  // X-axis label
//  textAlign(CENTER, CENTER);
//  text("Time (s)", hWindowWidth / 2, yBase + hGraphHeight + 40);

//  // Draw Y-axis labels
//  textAlign(RIGHT, CENTER);
//  textSize(12);
//  text("30°F", hMargin - 10, yBase); // Top value (maximum temperature)
//  text("150°F", hMargin - 10, yBase + hGraphHeight); // Bottom value (minimum temperature)

//  // Draw X-axis labels
//  textAlign(CENTER, TOP);
//  text("0", hMargin, yBase + hGraphHeight + 10); // Start of X-axis
//  text("100", hWindowWidth - hMargin, yBase + hGraphHeight + 10); // End of X-axis

//  // Placeholder for graph line
//  fill(hGraphColor);
//  noStroke();
//  textAlign(CENTER, CENTER);
//  text("No Data Available", hWindowWidth / 2, yBase + hGraphHeight / 2);
  
  
//}
