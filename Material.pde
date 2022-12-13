class Material {
  // FIELDS
  float mass; //grams
  float heatCapacity; // (J/kg*C)
  float temperatureInitial, temperatureFinal, temperatureIncrease; //in celsius
  float ignitionTemperature;
  String option; //wood,paper,ants or grass
  MagnifyingGlass glass;
  float x,y;
  float w,hei;
  float vX;
  float beamIntensity;
  float wavelength;
  float maximumTemperature;
  PVector ignitionCoordinates;


  // CONSTRUCTOR
  Material(float m, String o, MagnifyingGlass mg) {
    this.mass = m;
    this.option = o;
    this.glass = mg;
    this.x = 300;
    this.y = 500;
    this.w = 20*this.mass;
    this.hei = 10*this.mass;
    this.vX = 0;
    this.beamIntensity = 1;
    
    if (this.option.equals("grass")) {
      this.maximumTemperature = 1100;
      this.ignitionTemperature = 100;
      this.heatCapacity = 0.79496;
    }
    else if (this.option.equals("wood")) {
      this.maximumTemperature = 1200;
      this.ignitionTemperature = 260;
      this.heatCapacity = 1.76;
    }
    else if (this.option.equals("ant")) {
      this.maximumTemperature = 550;
      this.ignitionTemperature = 410; //ignition tempeature of cellulose
      this.heatCapacity = 2.11; //ant exoskeleton are made of chitin, comparable to cellulose
      this.vX = 1;  
  }
    else if (this.option.equals("paper")) {
      this.maximumTemperature = 1230;
      this.ignitionTemperature = 233;
      this.heatCapacity = 1.4;
    }
    
    this.temperatureIncrease = (this.glass.numPhotonsHittingGlass*conversionEfficiency*h*f*this.beamIntensity)/(this.mass * this.heatCapacity);
    this.temperatureInitial = surroundingTemperature;
    this.temperatureFinal = this.temperatureInitial;
  }

  // METHODS
  void drawMe() {
    if (this.option.equals("grass")) {
      drawGrass();
    }
    else if (this.option.equals("wood")) {
      drawWood();
    }
    else if (this.option.equals("ant")) {
      drawAnt();
    }
    else {
      drawPaper();
    }
  }
  

  void updateMe() {
    boolean burning;
    this.temperatureIncrease = (this.glass.numPhotonsHittingGlass*conversionEfficiency*h*f*this.beamIntensity*this.glass.transparency)/(this.mass * this.heatCapacity);
    
    // Checks if the focal point of the lens is on the material 
    if(this.option.equals("grass")||this.option.equals("paper")){
      burning = ((this.glass.focalX>=this.x && this.glass.focalX<=this.x+this.w) && (this.glass.focalY>=this.y && this.glass.focalY<=this.y+this.hei));
    }
    
    else if (this.option.equals("wood")){
    // check if the focal point is within an ellipse 
      burning = pow(this.glass.focalX-this.x,2)/pow(this.w/2,2)+pow(this.glass.focalY-this.y,2)/pow(this.hei/2,2)<=1;
    }
    
    else{
      //estimates a circle around an ant, checks if focal point is within the circle
      burning = (dist(this.glass.focalX, this.glass.focalY, this.x, this.y) < 15); 
      //rect(this.x1 - 10, this.y1 - 5, this.x1 + 20, this.y1+5);
      circle(this.x, this.y, 15);
    }
    
    if(burning){
      
      if(this.temperatureFinal < this.maximumTemperature){
        // Updates the temperature label on the GUI
        currentTemperature.setText(str(round(temperatureFinal*100.0)/100.0) + "\u00B0C");
        this.temperatureFinal += temperatureIncrease;
      } 
    }
    
    if (this.temperatureFinal > this.ignitionTemperature) {
      
      // Set the ignition point 
      if(ignitionCoordinates == null) {
        ignitionCoordinates = new PVector (this.glass.focalX, this.glass.focalY);
      }
      
      // Adds smoke to the smoke list if the temperature is greater than the ignition temperature. 
      if (frameCount%3 == 0) {
         for (int i = 0; i <= 10; i++) { 
           Smoke sm = new Smoke(this.ignitionCoordinates.x,this.ignitionCoordinates.y);
           smokeList.add(sm);
         }
      }
   }
    
    // Draw both smoke and sparks if the temperature of the object is 100 degrees hotter than its ignition temperature
    if (this.temperatureFinal > this.ignitionTemperature+70) {
      if (frameCount%3 == 0) {
        sparkList.clear();
        
        // Draws the smoke
        for (int i=0; i<=10; i++) { 
           Smoke sm = new Smoke(this.ignitionCoordinates.x,this.ignitionCoordinates.y);
           smokeList.add(sm);
        }
         
        // Draws the sparks
        for (int i=0; i<=40; i++) { //the for loop only runs once in the program
           Spark sp = new Spark(this.ignitionCoordinates.x,this.ignitionCoordinates.y);
           sparkList.add(sp);
        }
      }
    }
  }
  
  // Draws the grass material
  void drawGrass() {
    strokeWeight(1);
    stroke(0);
    fill(140, 194, 93);
    rect(this.x,this.y,this.w,this.hei);
    
    int numRows = 5;
    int deltaY = int(this.hei / numRows);
    for(int i = 0; i < numRows; i++){
      drawOneLine(int(this.x), int(this.x + this.w), int(this.y + i * deltaY + 10));
    }
    
    if(this.hei > 200) {
      this.hei = 200;
    }
    
    if(this.w > 200) {
      this.w = 200;
    }
  }
  
  // Draws the wood material
  void drawWood() {
    stroke(89, 52, 8);
    strokeWeight(10);
    ellipse(this.x, this.y, this.w, this.hei);
    
    strokeWeight(1);
    fill(232, 170, 108);
    
    float ellipseW = this.w;
    float ellipseHei = this.hei;
    int num = int(this.mass);
    
    for(int i = 0; i < num; i++){
      ellipse(this.x, this.y, ellipseW, ellipseHei);
      ellipseW -= 20;
      ellipseHei -= 10;
    }
  }
  
  // Draws the "ant" material 
  void drawAnt() {
    // If the current temperature is less than the ignition temperature
    if(this.temperatureFinal <= this.ignitionTemperature){
      
      // If the body temperature of the ant is less than 40, have it move left to right
      if(this.temperatureFinal <= 40) {
        if(this.x == 500) {
          this.vX = -1;
        }
        else if (this.x == 300){
          this.vX = 1;
        }
      }
      
      // If its body temperature is too high, have it stay still
      else {
        this.vX = 0;
      }
      
      this.x += this.vX;
    }
    
      stroke(0);
      fill(0);
      circle(this.x,this.y,5);
      circle(this.x-5,this.y,5);
      circle(this.x+5,this.y,5);
      line(this.x-5, this.y,this.x-10,this.y-10);
      line(this.x-5, this.y,this.x,this.y-10);
  }
  
  // Draws the paper material 
  void drawPaper() {
    strokeWeight(1);
    stroke(0);
    fill(241, 238, 235);
    rect(this.x,this.y,this.w,this.hei);
  }
}
