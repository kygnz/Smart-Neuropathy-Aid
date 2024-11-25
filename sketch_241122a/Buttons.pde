// Navigation Button Class
class MainButton {
  float x, y, w, h;
  String label;
  color bgColor, textColor;
  boolean isPressed;

  MainButton(float x, float y, float w, float h, String label, boolean isPressed) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.bgColor = color(200);  // Default background color
    this.textColor = color(0);// Default text color
    this.isPressed = isPressed;
  }

  color getColor(){
    if(isPressed){
      return color(240);
    }
    return color(200);
  }
  
  void display() {
    fill(getColor());
    noStroke();
    rect(x, y, w, h);
    fill(textColor);
    textAlign(CENTER, CENTER);
    textSize(16);
    text(label, x + w / 2, y + h / 2);
  }
  

  boolean isClicked(float mouseX, float mouseY) {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }
}



// Summary Window Buttons
class MoreInfoButton {
  float x, y, w, h;
  String label;
  color bgColor, textColor;

  MoreInfoButton(float x, float y, float w, float h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.bgColor = color(200);  // Default background color
    this.textColor = color(255);// Default text color
  }

  
  void display() {
    fill(100, 150, 200);
    noStroke();
    rect(x, y, w, h, 10);
    fill(textColor);
    textAlign(LEFT);
    textSize(14);
    float padding = 10;
    text(label, x + padding, y + h / 2);
  }
  

  boolean isClicked(float mouseX, float mouseY) {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }
}
