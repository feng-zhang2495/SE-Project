class MagnifyingGlass {
  // FIELDS
  float glassArea;
  String lensQuality;
  float transparency;
  float x, y;
  float focalX,focalY;
  float focalLength;
  float radius; //in m
  float numPhotonsHittingGlass; //per second

  // CONSTRUCTOR
  MagnifyingGlass(float r, String l, float focalLength) { 
    this.radius = r;
    this.glassArea = PI*pow(this.radius,2);
    this.lensQuality = l;
    
    if(this.lensQuality.equals("Clear")){
      this.transparency = 1;
    }
    
    else if(this.lensQuality.equals("Impurities")){
      this.transparency = 0.75;
    }
    
    else if(this.lensQuality.equals("Dirty")){
      this.transparency = 0.5;
    }
    
    this.x = 300;
    this.y = 300;
    this.focalX = this.x;
    this.focalLength = focalLength;
    this.focalY = this.y+8*focalLength;
    this.numPhotonsHittingGlass = this.glassArea*photonsPerMetersSquared;
  }
  
  // METHODS 
  // Draws the magnifying glass 
  void drawMe() {  
    fill(0);
    noStroke();
    rect(this.x-radius*4000, this.y-5, 100, 10);
    
    // Fills the lens with a different color depending on the quality
    lensQuality();
    ellipse(this.x, this.y,this.radius*4000,30);
  }
  
  // Assigns a different fill for the magnifying glass lens based on how clean it is
  void lensQuality(){
    if(this.lensQuality.equals("Clear")){
      fill(172, 252, 252);
    }
    
    else if(this.lensQuality.equals("Impurities")){
      fill(89, 135, 135);
    }
    
    else if(this.lensQuality.equals("Dirty")){
      fill(105, 68, 66);
    }
  }
}
