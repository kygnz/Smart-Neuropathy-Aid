int windowWidth = 440;
int windowHeight = 770;
int margin = 60;         // Space around the graph
int graphHeight = (windowHeight - (margin * 5)) / 4; // Same style as first graph
color graphColor = color(0, 119, 182);  // Blue color for the graph


void drawTempScreen(){
  background(236);
  // Current Temperature Section
  fill(0, 48, 73); 
  textAlign(CENTER, CENTER);
  textSize(14);
  text("Current Temperature:", width / 2, height / 10);
  textSize(54);
  if(temperatureData.size()>0){
  text(int(temperatureData.get(temperatureData.size()-1))+"° F", width / 2, height / 10 + 55);    // replace with variable for actual data
  
  // average temperature:
  textSize(14);
    // Calculate the average
        float sum = 0.0f;
        for (Float temp : temperatureData) {
            sum += temp;
        }

        int average =int( sum / temperatureData.size());

  text("Average: " + average+"° F", width / 2, height / 10 + 95); // replace with variable for actual data
  }
  // display temeprature graph
  drawTempGraph(temperatureData); 
  
}



void drawTempGraph(ArrayList<Float> temperatureData ){
 int yBase = 270;      // Top margin for the graph
  int yMax = 150;    // Maximum value on Y-axis (°F)
  int yMin = 30;   // Minimum value on Y-axis (°F)
  
  // Draw background
  fill(255);
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
  line(margin, yBase, margin, yBase + graphHeight);            // Y-axis
  line(margin, yBase + graphHeight, windowWidth - margin, yBase + graphHeight);  // X-axis
  
  // Draw Y-axis label
  fill(0, 48, 73);
  textSize(14);
  pushMatrix();
  translate(margin - 40, yBase + graphHeight / 2);
  rotate(-HALF_PI);
  text("Temperature (°F)", 0, 0);
  popMatrix();
  
  // Draw X-axis label
  textAlign(CENTER, CENTER);
  text("Time (s)", windowWidth / 2, yBase + graphHeight + 40);

  // Draw Y-axis labels
  textAlign(RIGHT, CENTER);
  textSize(12);
  text(nf(yMax, 0, 1) + "°F", margin - 10, yBase);
  text(nf(yMin, 0, 1) + "°F", margin - 10, yBase + graphHeight);
  
  // Draw X-axis labels
  textAlign(CENTER, TOP);
  int elapsedTime = (millis() - startTime) / 1000;  // Convert to seconds
  text(elapsedTime +" sec.", windowWidth - margin, yBase + graphHeight + 10);
  
  // Plot temperature data
  if (temperatureData != null && temperatureData.size() > 1) {
    stroke(graphColor);
    strokeWeight(2);
    noFill();
    beginShape();
    
    for (int i = 0; i < temperatureData.size(); i++) {
      float x = map(i, 0, temperatureData.size() - 1, margin, windowWidth - margin);
      float y = map(temperatureData.get(i), yMin, yMax, yBase + graphHeight, yBase);
      vertex(x, y);
    }
    
    endShape();
  } else {
    // Show placeholder text if no data is available
    fill(graphColor);
    noStroke();
    textAlign(CENTER, CENTER);
    text("No Data Available", windowWidth / 2, yBase + graphHeight / 2);
  }
}
