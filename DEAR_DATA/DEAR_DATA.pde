// -- Global variables to hold the data
String[] dearData;
String[][] data;
float lightSize = 50; // Define the size of the circles
String[]readMe;
boolean showTextBox = false;


//music links
String[] musicLinks = { 
  "https://youtu.be/_tIDKFZemZY?si=h2ZvEFW6rs32TEyO", // Monday
  "https://youtu.be/HwtEBQiuX-c?si=TZtyUzHeBqkVIr_U", //Tuesday
  "https://youtu.be/BFRuO-yRK5o?si=zSR30Hydb1R6p5Vd", // Wednesday
  "https://youtu.be/EMnQwBTJnMM?si=sDwAmisXHHNNFmFO", //Thursday
  "https://youtu.be/CAC-onWPMB0?si=nnx6EhwiD4kn1ZMj", //Friday
  "https://youtu.be/5XJLdu5qAhM?si=5rMVxODw_4QGLqxh", //Saturday
  "https://youtu.be/S9s4Ckt-aKo?si=edqgNrRNuYDAMQfS", //Sunday
};

void setup() {
  size(900, 575);
  textAlign(CENTER);
  textSize(21);
  ellipseMode(CENTER);

  // Load the data from the file 
  dearData = loadStrings("DEAR DATA CSV.csv");
  readMe = loadStrings("readMe.txt");


  // Checks if the file was loaded successfully
  if (dearData == null) {
    println("Error: File not found");
    exit();
  }
  if (readMe == null) {
    println("Error: readMe.txt file not found");
    exit();
  }

  data = new String[dearData.length][];

  //CSV file
  for (int i = 0; i < dearData.length; i++) {
    String[] dataItems = split(dearData[i], ",");
    data[i] = new String[dataItems.length];

   
    for (int d = 0; d < dataItems.length; d++) {
      data[i][d] = dataItems[d];
      println("Row:", i, "Column:", d, "Value:", dataItems[d]);
    }
  }

}

void draw() {
  background(250);

  
  for (int i = 0; i < data.length; i++) {
    float x = lightSize * 1.5; // x position of the data for this observation
    float y = lightSize + i * lightSize; // y position of data for this row/day
    String dayName = data[i][0]; // first element in each row is the name of the day
    fill (1, 1, 1);
    float textOffset = -lightSize * 0.14; // Adjust this value for better alignment
    fill(0);
    text(dayName, x, y + textOffset);

    
    for (int d = 1; d < data[i].length; d++) {
      String light = data[i][d];
      String lightText = "";
      color fillColour = color(255, 255, 255); // default color for marks

      // -- Condition to set colour and text depending on the data
      if (light.equals("HOME")) {
        fillColour = color(32, 200, 32, 128);
        lightText = "Home";
      } else if (light.equals("LTS")) {
        fillColour = color(255, 160, 32);
        lightText = "Local Train Station ";
      } else if (light.equals("UTS")) {
        fillColour = color(240, 64, 64);
        lightText = "University Train Station";
      } else if (light.equals("UNI")) {
        fillColour = color(#6406A0);
        lightText = "University";
      } else if (light.equals("COFFEE SHOP")) {
        fillColour = color(#5F80FF);
        lightText = "Coffee Shop";
      } else if (light.equals("CINEMA")) {
        fillColour = color(#E6ED29);
        lightText = "Cinema";
      } else if (light.equals("RESTAURANT")) {
        fillColour = color(#ED29E0);
        lightText = "Restaurant";
      } else if (light.equals("SHOP")) {
        fillColour = color(#36906E);
        lightText = "Shop";
      } else if (light.equals("CAFÉ")) {
        fillColour = color(#FFD700);
        lightText = "Café";
      } else if (light.equals("STAYED AT HOME")) {
        fillColour = color(#582222);
        lightText = "Stayed at Home";
      } else {
        continue; // Skip if data is not recognized
      }

      // Draw the circle with the correct color
      x += lightSize;
      noStroke();
      fill(fillColour);
      circle(x, y, lightSize * 0.8);

      // Adds the  mouse hover effect
      if (dist(mouseX, mouseY, x, y) < lightSize * 0.4) {
        stroke(32, 128);
        circle(x, y, lightSize * 0.9);
        fill(16, 200);
        text(lightText, mouseX, mouseY - 10);
      }
    }
  }
  textAlign(RIGHT, TOP);
  textSize(20);
  fill(0);
  text("Press Space for the README", width - 10, 10);
  
  if (showTextBox) {
    drawTextBox();
  }
}




void mouseMoved() {
  redraw(); // Redraw only once when the mouse is moved
}

void mousePressed() {
  for (int i = 0; i < data.length; i++) {
    float x = lightSize * 1.5;
    float y = lightSize + i * lightSize;
    String dayName = data[i][0];

    // Checks if the mouse is  clicked  within the bounds of the day text
    float textWidthHalf = textWidth(dayName) / 2;
    if (mouseX > x - textWidthHalf && mouseX < x + textWidthHalf &&
      mouseY > y - 10 && mouseY < y + 10) {
      println("Clicked on: " + dayName);
      link(musicLinks[i]); 
    }
  }
}





void drawTextBox() {
  //Text box dimensions
  float boxX = width * 0.1;
  float boxY = height * 0.1;
  float boxWidth = width * 0.8;
  float boxHeight = height * 0.8;

  //Background of the text box
  fill(#2d76d6);
  stroke(0);
  rect(boxX, boxY, boxWidth, boxHeight, 10);

  // Displays the readMe
  fill(0);
  textAlign(LEFT, TOP);
  textSize(15);

  float textX = boxX + 20;
  float textY = boxY + 20;
  float lineHeight = 20;

//wraps text within the text box
  for (int i = 0; i < readMe.length; i++) {
    text(readMe[i], textX, textY + i * lineHeight, boxWidth - 40, boxHeight - 40); 
  }
}

void keyPressed() {
  //Toggles the readMe text on and off
 
   if (key == ' ') { // Detect the space key
    showTextBox = !showTextBox; // Toggle the text box visibility
    redraw();
  }
}
