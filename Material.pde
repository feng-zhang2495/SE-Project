class Material {
  // FIELDS
  float mass; //grams
  float heatCapacity; // (J/kg*C)
  float temperatureInitial,temperatureFinal,temperatureIncrease; //in celsius
  float ignitionTemperature;
  String option; //wood,paper,ants or grass
  MagnifyingGlass glass;
  float x1,y1;
  float w,h;
  float beamIntensity;

  ArrayList<Smoke> smokeList = new ArrayList<Smoke>();
  ArrayList<Spark> sparkList = new ArrayList<Spark>();


  // CONSTRUCTOR
  Material(float m, float hC, float iT, String o, MagnifyingGlass mg) {
    
    this.mass = m;
    this.heatCapacity = hC;
    this.ignitionTemperature = iT;
    this.option = o;
    this.glass = mg;
    this.x1 = 300;
    this.y1 = 450;
    this.w = 200;
    this.h = 100;
    this.beamIntensity = 1;
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
      drawAnts();
    }
    else {
      drawPaper();
    }
    
    //draw smoke
    for (int i=0; i<smokeList.size(); i++){
      Smoke sm = smokeList.get(i);
      sm.drawMe();
      sm.updatePos();
      if(sm.y1<50){
        smokeList.remove(i);
      }
    } 
     
     //draw sparks
     for (int i=0; i<sparkList.size();i++){
        Spark sp = sparkList.get(i);
        sp.drawMe();
     }
  }
  

  void updateMe() {
    // Checks if the focal point of the mirror is on the material 
    boolean burning = ((this.glass.focalX>this.x1 && this.glass.focalX<this.x1+this.w) && (this.glass.focalY>this.y1 && this.glass.focalY<this.y1+this.h));
    
    //println(this.glass.focalX,this.glass.focalY);
    //println(burning);
    
    if(burning){
      this.temperatureFinal += temperatureIncrease;
      //println("final temp:",this.temperatureFinal);
    }
    
    if (this.temperatureFinal > this.ignitionTemperature) {
      //smoke only
      
        if (frameCount%3==0){
        //println("updating smoke only",frameCount);
        
         for (int i=0; i<=10; i++){ 
           Smoke sm = new Smoke(this.glass.focalX,this.glass.focalY);
           smokeList.add(sm);
         }
        }
    }
    
    // Draw both smoke and sparks if the temperature of the object is 100 degrees hotter than its ignition temperature
    if (this.temperatureFinal > this.ignitionTemperature+100) {
        if (frameCount%3==0){
        //println("updating smoke and sparks",frameCount);
        sparkList.clear();
        
        // Draws the smoke
        for (int i=0; i<=10; i++) { 
           Smoke sm = new Smoke(this.glass.focalX,this.glass.focalY);
           smokeList.add(sm);
        }
         
        // Draws the sparks
        for (int i=0; i<=40; i++) { //the for loop only runs once in the program
           Spark sp = new Spark(this.glass.focalX,this.glass.focalY);
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
    rect(this.x1,this.y1,this.w,this.h);
  }
  
  // Draws the wood material
  void drawWood() {
    strokeWeight(1);
    stroke(0);
    fill(232, 170, 108);
    rect(this.x1,this.y1,this.w,this.h);
  }
  
  // Draws the "ant" material 
  void drawAnts() {
    strokeWeight(1);
    stroke(0);
    fill(0);
    rect(this.x1,this.y1,this.w,this.h);
  }
  
  // Draws the paper material 
  void drawPaper() {
    strokeWeight(1);
    stroke(0);
    fill(241, 238, 235);
    rect(this.x1,this.y1,this.w,this.h);
  }
}
