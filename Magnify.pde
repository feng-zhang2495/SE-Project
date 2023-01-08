// GLOBAL VARIABLES
import g4p_controls.*;

// E = hf, h = Planck's Constant, f = c/wavelength
float h = 6.626*pow(10,-34);
float wavelength = pow(10, -8);
float c = 3*pow(10, 8);
float f = c/wavelength;

float photonsPerMetersSquared = 3.6*pow(10,21); //num photons hitting glass per second in typical outdoor brightness
float conversionEfficiency = 0.003; //amount of light energy turning into heat in decimals

float surroundingTemperature = 25;
String currentMaterial = "grass";
float xPosGlass, yPosGlass;

MagnifyingGlass magnifyingGlass = new MagnifyingGlass(0.03, "Clear", 25);
Material material = new Material(2, currentMaterial, magnifyingGlass);
Ray ray = new Ray(magnifyingGlass);

Boolean running = true;

ArrayList<Smoke> smokeList = new ArrayList<Smoke>();
ArrayList<Spark> sparkList = new ArrayList<Spark>();

// Setup
void setup() {
  size(800,800);
  createGUI();
  window1.loop();
}

// Draw 
void draw() {  
  // Gets the data values from the GUI
  getValuesFromGUI();
  
  // Draws the background, magnifying glass, and the material selected
  drawBackground();
  magnifyingGlass.drawMe();
  material.drawMe();
  
  //Draws the smoke coming out from the material and updates its position
  for(int i = 0; i < smokeList.size(); i++){
    Smoke sm = smokeList.get(i);
    sm.drawMe();
    sm.updatePos();
    
    // If the smoke's y-coordinate is off the screen, remove it from the smokelist
    if(sm.y1 < 50){
      smokeList.remove(i);
    }
  } 
   
   //Draw the sparks coming out from the material 
   for(int i = 0; i < sparkList.size(); i++){
      Spark sp = sparkList.get(i);
      sp.drawMe();
   }
  
  // Draws the light rays from the magnifying glass
  ray.drawMe();
  
  // Updates all the calculations and the positions for the next frame
  material.updateMe();
}

// Gets certain values from the GUI every frame
void getValuesFromGUI() {
  xPosGlass = xPositionSlider.getValueF(); 
  yPosGlass = yPositionSlider.getValueF();
  
  // Updates the values in magnifying glass class
  magnifyingGlass.x = xPosGlass;
  magnifyingGlass.y = yPosGlass;
  magnifyingGlass.focalX = xPosGlass;
  magnifyingGlass.focalY = yPosGlass + 5 * focalDistanceSlider.getValueF();
  
  // Gets the mass value from the mass slider 
  float m = massSlider.getValueF();
  
  // Setting the mass, width and height of the material based on the mass
  material.mass = m;
  material.w = 20*m;
  material.hei = 10*m;
  
  // Ensuring the material is not too wide or tall
  if(material.hei > 200) {
      material.hei = 200;
    }
    
  if(material.w > 300) {
    material.w = 300;
  }
}

// Draws the background of the animation 
void drawBackground() {
  background(114, 220, 252);
  
  // Draws the sand
  fill(255, 239, 189);
  rect(0, 500, width, 570);
  fill(253, 228, 150);
  rect(0, 600, width, height);
}

// Draws one line of triangular grass
void drawOneLineGrass(int x1, int x2, int y) {
  fill(140, 194, 93);
  strokeWeight(1);
  stroke(0);
  
  // Finding the total number of triangles in one line
  int numTriangles = int((x2 - x1) / 10);

  // Drawing all the triangles in one line 
  for(int i = 0; i < numTriangles; i++){ 
    triangle(x1, y, x1 + 5, y - 20, x1 + 10, y);
    x1 += 10;
  }
}

// Resets the animation
void reset() {
  magnifyingGlass = new MagnifyingGlass(0.03, "Clear", surroundingTemperature);
  material = new Material(2, currentMaterial, magnifyingGlass);
  ray = new Ray(magnifyingGlass);
  
  smokeList = new ArrayList<Smoke>();
  sparkList = new ArrayList<Spark>();
  
  currentTemperature.setText(str(surroundingTemperature));
}
