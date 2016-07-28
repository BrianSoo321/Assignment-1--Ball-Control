
int gray = 0;
float x;
float y;
float easing = 0.05;

void setup() {
  size(640, 360); 

}

void draw() { 
  background(gray);
  
  //EVENT FLOW
  line(mouseX, 0, mouseX, 640);
  line(0, mouseY, 640, mouseY);
   
 // CURSOR ICON
  if (mousePressed == true) {
    cursor(HAND); // Draw cursor as hand
  } else {
    cursor(CROSS);
  }

  
  float targetX = mouseX;
  float dx = targetX - x;
  x += dx * easing;
  
  // MOUSE DATA
  float targetY = mouseY;
  float dy = targetY - y;
  y += dy * easing;
  float ix = width - mouseX; // Inverse X
  float iy = height - mouseY; // Inverse Y
  fill(255, 150);
  ellipse(x, height/2, y, y);
  fill( random(255), random(255), random(255), 200);
  ellipse(ix, height/2, iy, iy);
  ellipse(x, y, 66, 66);
  
  // MOUSE BUTTONS
  if (mousePressed == true) {
    fill(255,0,0,200); // red
  } else {
    fill(0,0,255,200); // Blue
  }
  rect(25, 25, 10, 10);
  rect(25, 125, 10, 10);
  rect(25, 225, 10, 10);
  rect(25, 320, 10, 10);
  rect(600, 25, 10, 10);
  rect(600, 125, 10, 10);
  rect(600, 225, 10, 10);
  rect(600,320 , 10, 10);

// KEYBOARD DATA
if (keyPressed == true) { // If the key is pressed,
    rect(200, 100, 200, 150); // draw a rectangle
  } 
}
void mouseReleased() {
  gray += 20;
  
}
void mousePressed() {
  redraw(); // Run the code in draw one time
}