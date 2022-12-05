// GLOBAL VARIABLES

//E = hf
float h = 6.63*pow(10,-34); // Planck's Constant
float f = pow(10,18); 

float photonsPerMetersSquared = 3.6*pow(10,18); //num photons hitting glass per second in typical outdoor brightness
float conversionEfficiency = 0.003; //amount of light energy turning into heat
float surroundingTemperature = 25;

MagnifyingGlass magnifyingGlass = new MagnifyingGlass(0.03,"Clear",400,300,25);
Material grass = new Material(2, 0.79496, 100, "grass", magnifyingGlass);
Ray ray = new Ray(magnifyingGlass);

Boolean running = true;


ArrayList<Smoke> smokeList = new ArrayList<Smoke>();
ArrayList<Spark> sparkList = new ArrayList<Spark>();
  
void setup() {
  size(800,800);
}

void draw() {  
  // Draws all the stuff in the ground
  drawBackground();
  magnifyingGlass.drawMe();
  grass.drawMe();
  ray.drawMe();
  
  // Updates all the calculations and the positions for the next frame
  grass.updateMe();
}

void drawBackground() {
  int x = 0;
  int y = 350;
  background(114, 220, 252);
  
  
  for(int z = 0; z < 15; z++){
    drawOneLine(x,y);
    y += 15;
  }
  
  // Draws the ground and dirt
  rect(0, 500, width, 570);
  fill(131,101,57);
  rect(0, 600, width, height);
}

// Draws the triangular grass
void drawOneLine(int x, int y) {
  fill(44, 163, 60);
  strokeWeight(1);
  stroke(0);
  
  for(int i = 0; i < 90; i++) {
    for(int j = 0; j < 4; j++) {      
      triangle(x, y, x+5, y-20, x+10, y);
      x+=10;
    }
    //y-=10;
  }
}
