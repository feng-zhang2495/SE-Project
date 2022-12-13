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

MagnifyingGlass magnifyingGlass = new MagnifyingGlass(0.03, "Clear", 25);
Material material = new Material(2, currentMaterial, magnifyingGlass);
Ray ray = new Ray(magnifyingGlass);

float xPosGlass, yPosGlass;
Boolean running = true;



ArrayList<Smoke> smokeList = new ArrayList<Smoke>();
ArrayList<Spark> sparkList = new ArrayList<Spark>();
  
void setup() {
  size(800,800);
  createGUI();
}

void draw() {  
  // Gets the values from the GUI
  getValuesFromGUI();
  
  // Draws all the stuff in the ground
  drawBackground();
  magnifyingGlass.drawMe();
  material.drawMe();
  
  
  //Draw Smoke
  for (int i = 0; i < smokeList.size(); i++){
    Smoke sm = smokeList.get(i);
    sm.drawMe();
    sm.updatePos();
    if(sm.y1<50){
      smokeList.remove(i);
    }
  } 
   
   //Draw Sparks
   for (int i = 0; i < sparkList.size(); i++){
      Spark sp = sparkList.get(i);
      sp.drawMe();
   }
     
  ray.drawMe();
  
  // Updates all the calculations and the positions for the next frame
  material.updateMe();
}

void getValuesFromGUI() {
  xPosGlass = xPositionSlider.getValueF(); 
  yPosGlass = yPositionSlider.getValueF();
  
  // Updates the values in magnifying glass class
  magnifyingGlass.x = xPosGlass;
  magnifyingGlass.y = yPosGlass;
  magnifyingGlass.focalX = xPosGlass;
  magnifyingGlass.focalY = yPosGlass + 5 * focalDistanceSlider.getValueF();
  
  // Updates the mass values 
  material.mass = massSlider.getValueF();
}

void drawBackground() {
  int x = 0;
  int y = 350;
  background(114, 220, 252);
  
  
  //for(int z = 0; z < 15; z++){
  //  drawOneLine(x,width,y);
  //  y += 15;
  //}
  
  // Draws the sand
  fill(255, 239, 189);
  rect(0, 500, width, 570);
  fill(253, 228, 150);
  rect(0, 600, width, height);
}

// Draws the triangular grass
void drawOneLine(int x1, int x2, int y) {
  if(x2 == width){
    fill(44, 163, 60);
  }
  else{
    fill(140, 194, 93);
  }
  
  strokeWeight(1);
  stroke(0);
  int numTriangles = (x2 - x1) / 10;

  for(int i=0; i<numTriangles; i++){ 
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
