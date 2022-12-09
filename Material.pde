class Material {
  // FIELDS
  float mass; //grams
  float heatCapacity; // (J/kg*C)
  float temperatureInitial,temperatureFinal,temperatureIncrease; //in celsius
  float ignitionTemperature;
  String option; //wood,paper,ants or grass
  MagnifyingGlass glass;
  float x1,y1;
  float w,hei;
  float vX;
  float beamIntensity;
  float wavelength;
  float maximumTemperature;

  ArrayList<Smoke> smokeList = new ArrayList<Smoke>();
  ArrayList<Spark> sparkList = new ArrayList<Spark>();


  // CONSTRUCTOR
  Material(float m, String o, MagnifyingGlass mg) {
    
    this.mass = m;
    this.option = o;
    this.glass = mg;
    this.x1 = 300;
    this.y1 = 500;
    this.w = 200;
    this.hei = 50;
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
    else {
      this.maximumTemperature = 1230;
      this.ignitionTemperature = 233;
      this.heatCapacity = 1.4;
    }
    this.temperatureIncrease = (this.glass.numPhotonsHittingGlass*conversionEfficiency*h*f*this.beamIntensity)/(this.mass * this.heatCapacity);
    println(temperatureIncrease);
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
    boolean burning;
    // Checks if the focal point of the mirror is on the material 
    if(this.option.equals("grass")||this.option.equals("paper")){
      burning = ((this.glass.focalX>=this.x1 && this.glass.focalX<=this.x1+this.w) && (this.glass.focalY>=this.y1 && this.glass.focalY<=this.y1+this.hei));
    }
    else if (this.option.equals("wood")){
      //use ellipse formula from https://math.stackexchange.com/a/76463
      burning = false;
    }
    else{
      //estimate an ellipse around ant, check if focal point is within the ellipse
      burning = false;  
    }
    
    
    
    
    if(burning){
      
    
      if(this.temperatureFinal < this.maximumTemperature){
        // Updates the temperature label on the GUI
        currentTemperature.setText(str(round(temperatureFinal*100.0)/100.0) + "\u00B0C");
      
        this.temperatureFinal += temperatureIncrease;
        println(temperatureIncrease);
        println("final temp:",this.temperatureFinal);
      }
      
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
    rect(this.x1,this.y1,this.w,this.hei);
    
    int numRows = 5;
    int deltaY = int(this.hei/numRows);
    for(int i = 0; i < numRows; i++){
      drawOneLine(int(this.x1),int(this.x1+this.w),int(this.y1+i*deltaY+10));
  }
  }
  
  // Draws the wood material
  void drawWood() {
    stroke(89, 52, 8);
    strokeWeight(10);
    ellipse(this.x1+(this.w/2),this.y1+this.hei/2+5,this.w-10,this.hei-10);
    
    strokeWeight(1);
    fill(232, 170, 108);
    float ellipseW = this.w;
    float ellipseHei = this.hei;
    int num = 5;
    for(int i=0;i<num;i++){
      ellipse(this.x1+(this.w/2),this.y1+this.hei/2,ellipseW,ellipseHei);
      ellipseW -= 20;
      ellipseHei -= 10;
    }
  }
  
  // Draws the "ant" material 
  void drawAnts() {
    if(this.x1==500){
      this.vX = -1;
    }
    else if (this.x1==300){
      this.vX = 1;
    }
    this.x1+=this.vX;
    stroke(0);
    fill(0);
    circle(this.x1,this.y1,5);
    circle(this.x1-5,this.y1,5);
    circle(this.x1+5,this.y1,5);
    line(this.x1-5, this.y1,this.x1-10,this.y1-10);
    line(this.x1-5, this.y1,this.x1,this.y1-10);
  }
  
  // Draws the paper material 
  void drawPaper() {
    strokeWeight(1);
    stroke(0);
    fill(241, 238, 235);
    rect(this.x1,this.y1,this.w,this.hei);
  }
}
