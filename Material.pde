class Material {
  // FIELDS
  float mass; //grams
  float heatCapacity; // (J/kg*C)
  float temperatureInitial;
  float temperatureFinal;
  float ignitionTemperature;
  boolean ignition;
  String option; //wood,paper,ants or grass
  MagnifyingGlass glass;
  float x1, x2;
  float y1, y2;
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
    this.x1 = 200;
    this.y1 = 200;
    this.x2 = 400;
    this.y2 = 400;
    this.beamIntensity = 1;
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

    // for (int i=0; i<smokeList.size(); i++){
    //   Smoke sm = smokeList.get(i);
    //   sm.drawMe();
    //   sm.updateMe();
    //   if(sm.y1<200){
    //     smokeList.remove(i);
    //   }
    // }

    // for (int i=0; i<sparkList.size();i++){
    //   Spark sp = smokeList.get(i);
    //   sp.drawMe();
    //   sp.updateMe();
    //   if(sp.y1<200){
    //     sparkList.remove(i);
    //   }
    // }
  }
  

  void updateMe() {
    //If focal point is on the object this runs 
    // calculateHeatGenerated() 
    // if(Magnifying)
    // transparency * 
    float temperatureIncrease = photonsPerMetersSquared * conversionEfficiency * h * f / (mass * heatCapacity) * beamIntensity; 
    this.temperatureInitial = surroundingTemperature;
    this.temperatureFinal = temperatureInitial + temperatureIncrease;
    this.temperatureInitial = temperatureFinal;

    if (this.temperatureFinal > this.ignitionTemperature) {
        Smoke smokePiece = new Smoke(glass.x,glass.y);
        smokeList.add(smokePiece);
    }
    
    if (this.temperatureFinal > this.ignitionTemperature + 30) {
      // draw sparks
        Spark spark = new Spark(glass.x,glass.y);
        sparkList.add(spark);
    }
  }
  
  void drawGrass() {
    fill(0,255,0);
    rect(x1,y1,x2,y2);
  }
  
  void drawWood() {
    fill(232, 170, 108);
    rect(x1,y1,x2,y2);
  }
  
  void drawAnts() {
    fill(0);
    rect(x1,y1,x2,y2);
  }
  
  void drawPaper() {
    fill(241, 238, 235);
    rect(x1,y1,x2,y2);
  }
}