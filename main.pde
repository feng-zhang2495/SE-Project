// GLOBAL VARIABLES
//E = hf.
float h = 6.63*pow(10,-34); // Plancks Constant
float f = pow(10,18);    //

float photonsPerMetersSquared = 3.6*pow(10,21); //num photons hitting glass per second in typical outdoor brightness
float conversionEfficiency = 0.003; //amount of light energy turning into heat
float originalTemperature;
float surroundingTemperature = 25;

Boolean running = true;
MagnifyingGlass magnifyingGlass;
Material grass;
 
  
void setup() {
  size(800,800);
  noLoop(); //take away later
  magnifyingGlass = new MagnifyingGlass(25.0, 25.0, 1);
  grass = new Material(2, 0.00079496, 100, "grass", magnifyingGlass);
  
}


void draw() {
  background(0);
  grass.drawMe();
  magnifyingGlass.drawMe();

}


void drawBackground() {
	int x = 0;
  int y = 350;
  background(114, 220, 252);
  for( int z = 0; z < 15; z++){
    Drawoneline(x,y);
    y+=15;
  }
}

void drawOneLine(int x, int y){
   for( int i = 0; i < 90; i++){
      for (int j = 0; j < 4; j++){
        fill(44, 163, 60);
        triangle(x,y, x+5,y-20, x+10,y);
        x+=10;
      }
      y-=10;
    }
}
