import controlP5.*;

ControlP5 cp5;
Chart myChart;
Textarea myTextarea;

int c = 0;

Println console;
int v1;
int gray = 0;
float x;
float y;
float easing = 0.05;

int myColorBackground = color(0,0,0);
RadioButton r1, r2;

void setup() {
  size(640, 360); 

cp5 = new ControlP5(this);
 myChart = cp5.addChart("dataflow")
               .setPosition(70, 195)
               .setSize(200, 100)
               .setRange(-20, 20)
               .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setStrokeWeight(1.5)
               .setColorCaptionLabel(color(40))
               ;

  myChart.addDataSet("incoming");
  myChart.setData("incoming", new float[100]);
  
      cp5.addSlider("v1")
         .setPosition(70, 40)
         .setSize(200, 20)
         .setRange(100, 300)
         .setValue(250)
         .setColorCaptionLabel(color(20,20,20));
         
         r1 = cp5.addRadioButton("radioButton")
         .setPosition(70,80)
         .setSize(40,20)
         .setColorForeground(color(120))
         .setColorActive(color(255))
         .setColorLabel(color(255))
         .setItemsPerRow(5)
         .setSpacingColumn(50)
         .addItem("50",1)
         .addItem("100",2)
         .addItem("150",3)
         .addItem("200",4)
         .addItem("250",5)
         ;
     
     for(Toggle t:r1.getItems()) {
       t.getCaptionLabel().setColorBackground(color(255,80));
       t.getCaptionLabel().getStyle().moveMargin(-7,0,0,-3);
       t.getCaptionLabel().getStyle().movePadding(7,0,0,3);
       t.getCaptionLabel().getStyle().backgroundWidth = 45;
       t.getCaptionLabel().getStyle().backgroundHeight = 13;
      cp5.enableShortcuts();
  frameRate(50);
  myTextarea = cp5.addTextarea("txt")
                  .setPosition(70, 120)
                  .setSize(100, 50)
                  .setFont(createFont("", 10))
                  .setLineHeight(14)
                  .setColor(color(200))
                  .setColorBackground(color(0, 100))
                  .setColorForeground(color(255, 100));
  ;

  console = cp5.addConsole(myTextarea);//
}
}

void draw() { 
  background(myColorBackground);
  myChart.push("incoming", (sin(frameCount*0.1)*10));
  ellipseMode(CENTER);
  float n = sin(frameCount*0.01)*300;
  fill(110, 255,220);  
  ellipse(width/2, height/2, n , n);
  
  println(frameCount+"\t"+String.format("%.2f", frameRate)+"\t"+String.format("%.2f", n));
  pushMatrix();

      pushMatrix();
     
      translate(200, 200);
      rotate(map(v1, 100, 300, -PI, PI));
     
      popMatrix();

      translate(600, 100);
      for (int i=0; i<20; i++) {
        pushMatrix();
        fill(255);
        translate(-300, i*80);
        rotate(map(v1+i, 0, 300, -PI, PI));
        rect(-300, 80, 900, 20);
        popMatrix();
      }

      popMatrix();

  
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
void keyPressed() {
  switch(key) {
    case('0'): r1.deactivateAll(); break;
    case('1'): r1.activate(0); break;
    case('2'): r1.activate(1); break;
    case('3'): r1.activate(2); break;
    case('4'): r1.activate(3); break;
    case('5'): r1.activate(4); break;
  }
}
  void controlEvent(ControlEvent theEvent) {
  if(theEvent.isFrom(r1)) {
    print("got an event from "+theEvent.getName()+"\t");
    for(int i=0;i<theEvent.getGroup().getArrayValue().length;i++) {
      print(int(theEvent.getGroup().getArrayValue()[i]));
    }
    println("\t "+theEvent.getValue());
    myColorBackground = color(int(theEvent.getGroup().getValue()*50),0,0);
  }
}

void radioButton(int a) {
  println("a radio Button event: "+a);
}