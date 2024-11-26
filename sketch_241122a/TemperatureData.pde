int windowWidth = 440;
int windowHeight = 770;
int margin = 60;         // Space around the graph
int graphHeight = (windowHeight - (margin * 5)) / 4; // Same style as first graph
color graphColor = color(250);

void drawTempScreen(){
  background(236);
  // Current Temperature Section
  fill(0, 48, 73); 
  textAlign(CENTER, CENTER);
  textSize(14);
  text("Current Temperature:", width / 2, height / 10);
  textSize(54);
  text("54° F", width / 2, height / 10 + 55);    // replace with variable for actual data
  
  // average temperature:
  textSize(14);
  text("Average: " + "56° F", width / 2, height / 10 + 95); // replace with variable for actual data
  
  // display temeprature graph
  drawTempGraph(); 
  
}



void drawTempGraph(){
  int yBase = 270; // Top margin for the graph

  fill(255); // White background
  noStroke();
  rect(margin - 10, yBase - 10, windowWidth - margin * 2 + 40, graphHeight + 40, 20);

  // Draw title
  fill(0, 48, 73);
  textAlign(CENTER, CENTER);
  textSize(18);
  text("Temperature Data", windowWidth / 2, yBase - 40);

  // Draw axes
  stroke(0);
  strokeWeight(1);
  line(margin, yBase, margin, yBase + graphHeight);  // Y-axis
  line(margin, yBase + graphHeight, windowWidth - margin, yBase + graphHeight);  // X-axis

  // Draw axis labels
  fill(0, 48, 73);
  textSize(14);

  // Y-axis label
  textAlign(CENTER, CENTER);
  pushMatrix();
  translate(margin - 40, yBase + graphHeight / 2);
  rotate(-PI / 2); // Rotate the text for vertical axis label
  text("Temperature (°F)", 0, 0);
  popMatrix();

  // X-axis label
  textAlign(CENTER, CENTER);
  text("Time (s)", windowWidth / 2, yBase + graphHeight + 40);

  // Draw Y-axis labels
  textAlign(RIGHT, CENTER);
  textSize(12);
  text("30°F", margin - 10, yBase); // Top value (maximum temperature)
  text("150°F", margin - 10, yBase + graphHeight); // Bottom value (minimum temperature)

  // Draw X-axis labels
  textAlign(CENTER, TOP);
  text("0", margin, yBase + graphHeight + 10); // Start of X-axis
  text("100", windowWidth - margin, yBase + graphHeight + 10); // End of X-axis

  // Placeholder for graph line
  fill(graphColor);
  noStroke();
  textAlign(CENTER, CENTER);
  text("No Data Available", windowWidth / 2, yBase + graphHeight / 2);
   
}
