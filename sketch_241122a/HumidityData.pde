
int hWindowWidth = 440;
int hWindowHeight = 770;
int hMargin = 60;         // Space around the graph
int hGraphHeight = (hWindowHeight - (hMargin * 5)) / 4; // Same style as first graph
color hGraphColor = color(250);


void drawHumidityScreen(){
  background(236);
  // Current Temperature Section
  fill(0, 48, 73); 
  textAlign(CENTER, CENTER);
  textSize(14);
  text("Current Humidity:", width / 2, height / 10);
  textSize(54);
  text("54° F", width / 2, height / 10 + 55);    // replace with variable for actual data
  
  // average temperature:
  textSize(14);
  text("Average: " + "56° F", width / 2, height / 10 + 95); // replace with variable for actual data
  
  // display temeprature graph
  drawHumidityGraph();
  
}


void drawHumidityGraph(){
  int yBase = 270; // Top margin for the graph

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
  text("Humidity (°F)", 0, 0);
  popMatrix();

  // X-axis label
  textAlign(CENTER, CENTER);
  text("Time (s)", hWindowWidth / 2, yBase + hGraphHeight + 40);

  // Draw Y-axis labels
  textAlign(RIGHT, CENTER);
  textSize(12);
  text("30°F", hMargin - 10, yBase); // Top value (maximum temperature)
  text("150°F", hMargin - 10, yBase + hGraphHeight); // Bottom value (minimum temperature)

  // Draw X-axis labels
  textAlign(CENTER, TOP);
  text("0", hMargin, yBase + hGraphHeight + 10); // Start of X-axis
  text("100", hWindowWidth - hMargin, yBase + hGraphHeight + 10); // End of X-axis

  // Placeholder for graph line
  fill(hGraphColor);
  noStroke();
  textAlign(CENTER, CENTER);
  text("No Data Available", hWindowWidth / 2, yBase + hGraphHeight / 2);
  
  
}
